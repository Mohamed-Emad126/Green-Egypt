import mongoose, { Document } from "mongoose";

export interface ICoupon extends Document {
    codes: string[];
    value: number;
    cost: number;
    brand: mongoose.Types.ObjectId;
    expiryDate: Date;
    usedCodes: {
        user: mongoose.Types.ObjectId;
        code: string;
        redeemedAt: Date;
    }[];
    //redeemed: boolean;
    addByAdmin: mongoose.Types.ObjectId;
    createdAt?: Date;
    updatedAt?: Date;
    deletedAt?: Date;
    deletedBy?:  mongoose.Types.ObjectId;
}

export interface ICouponInput {
    codes?: string[];
    value?: number;
    cost?: number;
    brand?: mongoose.Types.ObjectId;
    expiryDate?: Date;
    addByAdmin?: mongoose.Types.ObjectId;
}