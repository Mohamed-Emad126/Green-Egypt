import mongoose, { Document } from "mongoose";

export interface ICoupon extends Document {
    code: string;
    value: number;
    brand: mongoose.Types.ObjectId;
    expiryDate: Date;
    redeemed: boolean;
    addByAdmin: mongoose.Schema.Types.ObjectId;
}