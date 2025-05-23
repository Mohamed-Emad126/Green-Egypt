import Event from "../models/eventModel";
import trashEvent from "../models/trash/trashEventModel";
import uploadToCloud from "../config/cloudinary";
import { IEventInput, IEventFilter } from "../interfaces/iEvent";
import fs from "fs";
import mongoose from "mongoose";
import Partner from "../models/partnerModel";

export default class EventService {

    async getEvents(page: number, limit: number, filters?: IEventFilter) {
        const offset: number = (page - 1) * limit;

        const combinedFilters: any = { };
        
        if (filters?.timeFilter) {
            const dateFilter = this.prepareDateFilter(filters.timeFilter);
            Object.assign(combinedFilters, dateFilter);
        }

        const aggregationPipeline: any[] = [];

        if (filters?.location) {
            const userLocation = typeof filters.location === 'string' ? 
                JSON.parse(filters.location) : 
                filters.location;
                
            aggregationPipeline.push({
                $geoNear: {
                    near: {
                        type: "Point",
                        coordinates: userLocation.coordinates
                    },
                    distanceField: "distance",
                    maxDistance: 50000,
                    spherical: true,
                    query: combinedFilters
                }
            });
        } else {
            aggregationPipeline.push({
                $match: combinedFilters
            });
        }

        aggregationPipeline.push(
            {
                $lookup: {
                    from: "users",
                    localField: "_id",
                    foreignField: "interestedIn",
                    pipeline: [{ $count: "count" }],
                    as: "interestedUsersCount"
                }
            },
            {
                $unwind: {
                    path: "$interestedUsersCount",
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $addFields: {
                    interestedCount: { $ifNull: ["$interestedUsersCount.count", 0] },
                    distance: { $ifNull: ["$distance", 0] }
                }
            },
            {
                $sort: {
                    createdAt: -1
                }
            },
            {
                $skip: offset
            },
            {
                $limit: limit
            },
            {
                $project: {
                    _id: 1,
                    eventName: 1,
                    eventDate: 1,
                    location: 1,
                    city: 1,
                    eventImage: 1,
                    interestedCount: 1,
                }
            }
        );

        return await Event.aggregate(aggregationPipeline);
    }

    private prepareDateFilter(timeFilter: string) {
        const now = new Date();
        const filter: any = {};
        
        switch (timeFilter) {
            case 'thisWeek':
                const startOfWeek = new Date(now);
                startOfWeek.setDate(now.getDate() - ((now.getDay() + 1) % 7));
                startOfWeek.setHours(0, 0, 0, 0);
                
                const endOfWeek = new Date(startOfWeek);
                endOfWeek.setDate(startOfWeek.getDate() + 6);
                endOfWeek.setHours(23, 59, 59, 999);
                
                filter.eventDate = { $gte: startOfWeek, $lte: endOfWeek };
                break;
                
            case 'nextWeek':
                const nextWeekStart = new Date(now);
                nextWeekStart.setDate(now.getDate() + (6 - ((now.getDay() + 1) % 7)));
                nextWeekStart.setHours(0, 0, 0, 0);
                
                const nextWeekEnd = new Date(nextWeekStart);
                nextWeekEnd.setDate(nextWeekStart.getDate() + 6);
                nextWeekEnd.setHours(23, 59, 59, 999);
                
                filter.eventDate = { $gte: nextWeekStart, $lte: nextWeekEnd };
                break;
                
            case 'thisMonth':
                const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);
                const endOfMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0);
                endOfMonth.setHours(23, 59, 59, 999);
                
                filter.eventDate = { $gte: startOfMonth, $lte: endOfMonth };
                break;
        }
        
        return filter;
    }

    async getEventById(eventID : string) {
        const event =await Event.findById(eventID);
        return event ? event : null;
    }
    async createEvent(eventData : IEventInput) {
        const partner = await Partner.findById(eventData.organizedWithPartnerID);
        if (!partner) {
            return false;
        }

        const event = new Event({
            eventName: eventData.eventName,
            eventDate: eventData.eventDate,
            location: eventData.location,
            city: eventData.city,
            description: eventData.description,
            eventStatus : eventData.eventStatus,
            organizedWithPartnerID: eventData.organizedWithPartnerID,
        });
        await event.save();

        return event;
    }

    async updateEvent(eventID : string, eventData : IEventInput) {
        if(eventData.organizedWithPartnerID) {
            const partner = await Partner.findById(eventData.organizedWithPartnerID);
            if (!partner) {
                return { status: 404, message: 'Partner not found' };
            }
        }

        const existingEvent = await Event.findById(eventID);
        if (!existingEvent) {
            return { status: 404, message: "Event not found" };
        }


        await Event.findByIdAndUpdate(
            eventID, 
            {eventName: eventData?.eventName, eventDate: eventData?.eventDate, location: eventData?.location, city: eventData?.city, description: eventData?.description, eventStatus: eventData?.eventStatus, organizedWithPartnerID: eventData?.organizedWithPartnerID},
            {new : true, runValidators : true});

        return { status: 200, message: "Event updated successfully" };
    }

    async deleteEvent(eventID : string, deletedBy : string) {
        const event = await Event.findByIdAndUpdate(eventID, {eventStatus : 'cancelled'},{new : true, runValidators : true});
        if (!event){
            return false;
        }
        
        const toTrash = new trashEvent({...event.toObject(), deletedBy : new mongoose.Types.ObjectId(deletedBy)});
        await toTrash.save();

        await event.deleteOne();
        return true;
    }

    async uploadEventPicture(eventID : string, imageFile: any) {
        const event = await Event.findById(eventID);
        if (!event){
            return false;
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);

        event.eventImage = imageUploadResult.url;
        await event.save();
        fs.unlinkSync(imageFile.path);

        return true;
    }


    async addInterested(eventID : string, userID : string) {
        const event = await Event.findById(eventID);
        if (!event){
            return false;
        }

        event.interestedIn = event.interestedIn || [];
        if (!event.interestedIn.includes(userID)) {
            event.interestedIn.push(userID);
        }
        
        await event.save();
        return true;
    }

    async removeInterested(eventID : string, userID : string) {
        const event = await Event.findById(eventID);
        if (!event){
            return false;
        }

        if (event && event.interestedIn) {
            event.interestedIn = event.interestedIn.filter(id => id !== userID);
            await event.save();
            return true;
        }
    }
}

