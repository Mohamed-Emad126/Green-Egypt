import mongoose, { Document } from "mongoose";

export interface IEvent extends Document {
    eventName: string;
    eventDate: Date;
    location: string;
    organizedWithPartnerID: mongoose.Types.ObjectId;
}