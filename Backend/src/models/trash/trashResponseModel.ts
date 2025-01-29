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
            type: mongoose.Schema.Types.ObjectId,
            ref: "User" 
        },
        vote: Boolean,
    }],
    isVerified: {
        type: Boolean,
        default: false,
    },
    }, { timestamps: true });

const TrashResponse : Model<IResponse> = mongoose.model<IResponse>("TrashResponse", TrashResponseSchema);
export default TrashResponse;