import mongoose, { Schema, Model } from "mongoose";
import { IReport } from "../../interfaces/iReport";

const TrashReportSchema: Schema<IReport> = new mongoose.Schema({
    reportType: {
        type: String,
        enum: ['A tree needs care', 'A place needs tree', 'Other'],
        required: true
    },
    description: {
        type: String,
        required: true,
        maxLength: [600, 'Description cannot be more than 500 characters']
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
        default: 0 
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
    volunteering: {
        volunteer: {
            type: mongoose.Types.ObjectId,
            ref: 'User',
            default: null
        },
        at: Date || null
    },
    responses: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Response'
    }],
    comments: [{
        type:mongoose.Schema.Types.ObjectId, 
        ref: 'Comment'
    }],
    deletedAt: {
        type: Date,
        default: Date.now
    },
    deletedBy: {
        role: {
            type: String,
            enum: ['user', 'admin'],
        },
        hisID:{
            type: mongoose.Types.ObjectId,
            ref: 'User'
        }
    }
}, { timestamps: true });

const TrashReport: Model<IReport> = mongoose.model<IReport>('TrashReport', TrashReportSchema);
export default TrashReport;

