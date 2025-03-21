import mongoose, { Document } from "mongoose";

export interface IReport extends Document {
    reportType: 'A tree needs care' | 'A place needs tree' | 'Other';
    description: string;
    location: {
        type: string;
        coordinates: [number, number]
    };
    images: string[];
    createdBy: mongoose.Schema.Types.ObjectId;
    treeID?: mongoose.Schema.Types.ObjectId;
    upVotes: number;
    upVoters: mongoose.Schema.Types.ObjectId[];
    status : 'Pending' | 'In Progress' | 'Resolved' | 'Awaiting Verification';
    modificationHistory: {
        oldData: Partial<IReport>;
        updatedAt: Date;
    }[];
    volunteer?: mongoose.Types.ObjectId | null;
    responses: mongoose.Schema.Types.ObjectId[];
    comments: mongoose.Schema.Types.ObjectId[];
    createdAt?: Date
    updatedAt?: Date
}

export interface IReportInput {
    reportType?: 'A tree needs care' | 'A place needs tree' | 'Other';
    description?: string;
    location?: {
        type: string;
        coordinates: [number, number]
    };
    images?: string[];    
    treeID?: mongoose.Types.ObjectId;
    createdBy: mongoose.Types.ObjectId;
}