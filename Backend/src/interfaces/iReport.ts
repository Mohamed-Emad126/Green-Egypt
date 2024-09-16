import mongoose from "mongoose";

export interface IReport {
    reportType: 'A tree needs care' | 'A place needs tree' | 'Other';
    description: string;
    location: string;
    image: string;
    reportDate?: Date;
    reportedByUserID: mongoose.Schema.Types.ObjectId;
    treeID: mongoose.Schema.Types.ObjectId;
}