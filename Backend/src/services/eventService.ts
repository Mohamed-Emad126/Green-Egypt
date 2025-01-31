import Event from "../models/eventModel";
import trashEvent from "../models/trash/trashEventModel";
import uploadToCloud from "../config/cloudinary";
import { IEventInput } from "../interfaces/iEvent";
import fs from "fs";

export default class EventService {
    async getEvents(page : number, limit : number, filters : any) {
        const offset : number = (page - 1) * limit;
        return await Event.find(filters).skip(offset).limit(limit);
    }

    async getEventById(eventID : string) {
        const event =await Event.findById(eventID);
        return event ? event : null;
    }
    async createEvent(eventData : IEventInput) {
        const event = new Event({
            eventName: eventData.eventName,
            eventDate: eventData.eventDate,
            location: eventData.location,
            description: eventData.description,
            eventStatus : eventData.eventStatus,
            organizedWithPartnerID: eventData.organizedWithPartnerID,
        });
        await event.save();
        return event;
    }

    async updateEvent(eventID : string, eventData : IEventInput) {
        return await Event.findByIdAndUpdate(eventID, eventData,{new : true, runValidators : true});
    }

    async deleteEvent(eventID : string) {
        const event = await Event.findByIdAndUpdate(eventID, {eventStatus : 'cancelled'}, {new : true, runValidators : true});
        if (!event){
            return false;
        }
        
        const toTrash = new trashEvent({...event.toObject()});
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

        event.eventImage = {
            imageName: imageFile.filename,
            imageUrl: imageUploadResult.url
        };
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

    async countInterested(eventID : string) {
        const event = await Event.findById(eventID);
        if (!event){
            return false;
        }
        return event.interestedIn? event.interestedIn.length : 0;
    }
}

