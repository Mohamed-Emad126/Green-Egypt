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
    isVerified: {
        type: Boolean,
        default: false,
    },
    }, { timestamps: true });

const Response : Model<IResponse> = mongoose.model<IResponse>("Response", ResponseSchema);
export default Response;