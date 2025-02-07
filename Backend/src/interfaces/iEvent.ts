import mongoose, { Document } from "mongoose";

export interface IEvent extends Document {
    eventName: string;
    eventDate: Date;
    location: {
        latitude: number;
        longitude: number
    };
    description: string;
    eventImage: string;
    eventStatus: string;
    organizedWithPartnerID: mongoose.Types.ObjectId;
    interestedIn?: string[];
}

export interface IEventInput {
    eventName: string;
    eventDate: Date;
    location: string;
    description: string;
    eventImage?: string;
    eventStatus: string;
    organizedWithPartnerID: mongoose.Types.ObjectId;
}