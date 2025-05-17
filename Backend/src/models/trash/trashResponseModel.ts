import mongoose, {Schema, Model} from "mongoose";
import { IResponse } from "../../interfaces/iResponse";

const TrashResponseSchema: Schema<IResponse> = new mongoose.Schema({
    reportID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Report",
        required: true,
    },
    respondentID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
    images: [{
        type: String,
    }],
    votes: [{
        userID: { 
            type: mongoose.Types.ObjectId,
            ref: "User" 
        },
        vote: Boolean,
        _id: false 
    }],
    upVotes: {
        type: Number,
        default: 0,
    },
    downVotes: {
        type: Number,
        default: 0,
    },
    isVerified: {
        type: Boolean,
        default: false,
    },
    note: {
        message: String,
        status: String,
    },
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

const TrashResponse : Model<IResponse> = mongoose.model<IResponse>("TrashResponse", TrashResponseSchema);
export default TrashResponse;