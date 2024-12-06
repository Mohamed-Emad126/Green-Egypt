import mongoose, { Document } from "mongoose";

export interface IReport extends Document {
    reportType: 'A tree needs care' | 'A place needs tree' | 'Other';
    description: string;
    location: {
        latitude: number;
        longitude: number;
    };
    images: string[];
    createdBy: mongoose.Schema.Types.ObjectId;
    treeID: mongoose.Schema.Types.ObjectId;
    upVotes: number;
    upVoters: mongoose.Schema.Types.ObjectId[];
    status : 'Pending' | 'In Progress' | 'Resolved' | 'Rejected';
    modificationHistory: {
        oldData: Partial<IReport>;
        updatedAt: Date;
    }[];
    responses: mongoose.Schema.Types.ObjectId[];
    comments: mongoose.Schema.Types.ObjectId[];
    createdAt?: Date
}

export interface IReportInput {
    reportType?: 'A tree needs care' | 'A place needs tree' | 'Other';
    description?: string;
    location?: {
        latitude?: number;
        longitude?: number;
    };
    images?: string[];    
    treeID?: mongoose.Types.ObjectId;
    createdBy: mongoose.Types.ObjectId;
}