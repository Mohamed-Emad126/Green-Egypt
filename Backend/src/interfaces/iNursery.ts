import { Document } from "mongoose";

export interface INursery extends Document {
    nurseryname: string;
    nurseryPic:string;
    location: string;
}

export interface INurseryInput {
    nurseryname: string;
    nurseryPic:string;
    location: string;
}