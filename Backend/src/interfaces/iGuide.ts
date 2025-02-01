import { Document } from "mongoose";

export interface IGuide extends Document {
    articletitle: string;
    content: string;
    articlePic: {
        imageName:string;
        imageUrl:string;
    },
    createdAt: Date;
}

export interface IGuideInput {
    articletitle: string;
    content: string;
    articlePic?: string;
    createdAt: Date;
}