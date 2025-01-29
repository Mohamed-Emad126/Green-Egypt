import mongoose, { Document } from "mongoose";

export interface IComment extends Document {
    content: string;
    createdBy: mongoose.Types.ObjectId;
    reportID: mongoose.Types.ObjectId;
    modificationHistory: {
        oldData: Partial<IComment>;
        updatedAt: Date;
    }[];
    replies?: mongoose.Types.ObjectId[];
    parentCommentID?: mongoose.Types.ObjectId;
    createdAt?: Date;
    updatedAt?: Date
}