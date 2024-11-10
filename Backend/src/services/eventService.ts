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

    async deleteEventPicture(eventID: string) {
        const event = await Event.findById(eventID);
        if (!event){
            return false;
        }

        if(event.eventImage && event.eventImage.imageUrl !== '../uploads/not-found-image.png') {
            event.eventImage = { imageName: 'not-found-image.png', 
                                imageUrl: '../uploads/not-found-image.png' };
            await event.save();
            
        }

        return true;
    }

    
}