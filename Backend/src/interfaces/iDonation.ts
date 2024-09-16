import mongoose, { Document } from "mongoose";

export interface IDonation extends Document {
    amount: number;
    donationDate: Date;
    donatedByUserID: mongoose.Types.ObjectId;
    receiptNumber?: string;
}