import mongoose, {Schema, Model} from "mongoose";
import { IResponse } from "../interfaces/iResponse";

const ResponseSchema: Schema<IResponse> = new mongoose.Schema({
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
        status:{ 
            type: String,
            enum: ["accepted", "rejected", "accepted but rejected"]
        },
    }

}, { timestamps: true });

const Response : Model<IResponse> = mongoose.model<IResponse>("Response", ResponseSchema);
export default Response;