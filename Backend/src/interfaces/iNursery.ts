import { Document } from "mongoose";

export interface INursery extends Document {
    nurseryName: string;
    nurseryPic:string;
    address: string;
    location: {
        type: string;
        coordinates: [number, number]
    };
    rate: number;
}

export interface INurseryInput {
    nurseryName: string;
    nurseryPic:string;
    address: string;
}