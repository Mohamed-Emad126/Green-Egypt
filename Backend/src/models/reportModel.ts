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
        required: true,
        maxLength: [600, 'Description cannot be more than 600 characters']
    },
    location: {
        type: {
            type: String,
        },
        coordinates: {
            type: [Number],
        }
    },
    images: [
        {
            type: String,
        }
    ],
    createdBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    treeID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Tree',
    },
    upVotes: { 
        type: Number,
        default: 0, 
        min: [0, 'Up votes cannot be negative']
    },
    upVoters: [
        { 
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User'
        }
    ],
    status: {
        type: String,
        default: 'Pending',
        enum: ['Pending', 'In Progress', 'Resolved', 'Awaiting Verification'],
        required: true
    },
    modificationHistory: [{
        oldData: {
            type: Map,
            of: Schema.Types.Mixed,
        },
        updatedAt: { 
            type: Date, 
            default: Date.now 
        }
    }],
    volunteer: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        default: null
    },
    responses: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Response'
    }],
    comments: [{
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'Comment'
    }]
}, { timestamps: true });

ReportSchema.index({ location: '2dsphere' });

const Report: Model<IReport> = mongoose.model<IReport>('Report', ReportSchema);
export default Report;
