import mongoose, { Document } from "mongoose";

export interface IGuide extends Document {
    articleTitle: string;
    content: string;
    articlePic:string;
    createdAt: Date;
    updatedAt: Date;
    deletedAt?: Date;
    deletedBy?:  mongoose.Types.ObjectId;
}

export interface IGuideInput {
    articleTitle: string;
    content: string;
    articlePic?: string;
    createdAt: Date;
}