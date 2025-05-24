import mongoose, { Document } from "mongoose";

export interface IEvent extends Document {
    eventName: string;
    eventDate: Date;
    location: {
        type: string;
        coordinates: [number, number];
    };
    city: string;
    description: string;
    eventImage: string;
    eventStatus: string;
    organizedWithPartnerID: mongoose.Types.ObjectId;
    interestedIn?: string[];
    deletedAt?: Date;
    deletedBy?:  mongoose.Types.ObjectId;
}

export interface IEventInput {
    eventName: string;
    eventDate: Date;
    location: string;
    city: string;
    description: string;
    eventImage?: string;
    eventStatus: string;
    organizedWithPartnerID: mongoose.Types.ObjectId;
}

export interface IEventFilter {
    location?: string;
    timeFilter?: "thisWeek" | "nextWeek" | "thisMonth";
}