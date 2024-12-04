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
        latitude: {
            type: Number,
            required: true,
        },
        longitude: {
            type: Number,
            required: true,
        }
    },
    images: [{
        imageName: {
            type: String,
        },
        imageUrl: {
            type: String,
        }
    }],
    createdBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    treeID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Tree',
        required: true
    },
    upVotes: { 
        type: Number,
        default: 0 
    },
    status: {
        type: String,
        default: 'Pending',
        enum: ['Pending', 'In Progress', 'Resolved', 'Rejected'],
        required: true
    },
    modificationHistory: [
        {
            updatedData: { type: Object },
            updatedAt: { type: Date, default: Date.now }
        }
    ],
    responses: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Response'
    }],
    comments: [{
        type:mongoose.Schema.Types.ObjectId, 
        ref: 'Comment'
    }]
});

const TrashReport: Model<IReport> = mongoose.model<IReport>('TrashReport', TrashReportSchema);
export default TrashReport;

