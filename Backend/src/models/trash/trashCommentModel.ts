import mongoose, { Schema } from "mongoose";
import { IComment } from "../../interfaces/iComment";

const TrashCommentSchema: Schema = new Schema({
    content: {
        type: String,
        required: [true, "Content is required"],
        maxLength: [500, "Comment cannot be more than 500 characters"],
    },
    createdBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
    },
    reportID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Report",
        required: true,
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
    replies:[{
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'Comment'
    }],
    parentCommentID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Comment',
        default: null
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

const TrashComment = mongoose.model<IComment>("TrashComment", TrashCommentSchema);
export default TrashComment;
