import mongoose, { Document } from "mongoose";

export interface INursery extends Document {
    nurseryName: string;
    nurseryPic:string;
    address: string;
    location: {
        type: string;
        coordinates: [number, number]
    };
    rate: number;
    deletedAt?: Date;
    deletedBy?:  mongoose.Types.ObjectId;
}

export interface INurseryInput {
    nurseryName?: string;
    nurseryPic?:string;
    address?: string;
    location?: {
        type: string;
        coordinates: [number, number]
    };
    rate?: number;
}