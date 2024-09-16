import mongoose, { Schema, Model } from "mongoose";
import { IReport } from "../interfaces/iReport";

const ReportSchema: Schema<IReport> = new mongoose.Schema({
    reportType: {
        type: String,
        enum: ['A tree needs care', 'A place needs tree', 'Other'],
        required: true
    },
    description: {
        type: String,
        required: true
    },
    location: {
        type: String,
        required: true
    },
    image: {
        type: String,
        required: true
    },
    reportDate: {
        type: Date,
        default: Date.now
    },
    reportedByUserID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    treeID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Tree',
        required: true
    }
});

const Report: Model<IReport> = mongoose.model<IReport>('Report', ReportSchema);
export default Report;

