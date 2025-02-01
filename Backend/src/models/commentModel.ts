import mongoose, { Schema, Document } from "mongoose";
import { IComment } from "../interfaces/iComment";

const CommentSchema: Schema = new Schema({
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
        ref: 'comment'
    }],
    parentCommentID: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'comment',
        default: null
    }

}, { timestamps: true });

const Comment = mongoose.model<IComment>("Comment", CommentSchema);
export default Comment;
