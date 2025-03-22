import mongoose, { Document } from 'mongoose';

export interface IResponse extends Document {
    images: string[];
    respondentID: mongoose.Types.ObjectId;
    reportID: mongoose.Types.ObjectId;
    votes: {
        userID: mongoose.Types.ObjectId;
        vote: boolean;
    }[];
    upVotes: number;
    downVotes: number;
    isVerified: boolean;
    note: {
        message: string;
        status: string;
    } | null;
    updatedAt?: Date;
    createdAt?: Date;
}