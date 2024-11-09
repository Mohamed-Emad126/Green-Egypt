import mongoose, { Document } from "mongoose";

export interface IEvent extends Document {
    eventName: string;
    eventDate: Date;
    location: string;
    description: string;
    eventImage: {
        imageName: string;
        imageUrl: string
    };
    eventStatus: string;
    organizedWithPartnerID: mongoose.Types.ObjectId;
}

export interface IEventInput {
    eventName: string;
    eventDate: Date;
    location: string;
    description?: string;
    eventImage?: string;
    eventStatus: string;
    organizedWithPartnerID: mongoose.Types.ObjectId;
}