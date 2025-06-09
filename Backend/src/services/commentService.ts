import { IComment } from "../interfaces/iComment";
import Comment from "../models/commentModel";
import trashComment from "../models/trash/trashCommentModel";
import Report from "../models/reportModel";
import mongoose from "mongoose";

export default class CommentService {

    async createComment(data: Partial<IComment>) {
        const { content, createdBy, reportID, parentCommentID } = data;

        const report = await Report.findById(reportID);
        if (!report) {
            return false;
        }
    
        const newComment = await Comment.create({ content, createdBy, reportID, parentCommentID });
    
        if (parentCommentID) {
            const parentComment = await Comment.findById(parentCommentID);
            if (parentComment) {
                parentComment.replies!.push(newComment.id);
                await parentComment.save();
            }
        }

        report.comments.push(newComment.id);
        await report.save();
    
        return newComment;
    }

    async getCommentsByReport(page: number, limit: number, reportID: string) {
        const report = await Report.findById(reportID);
        if(!report) {
            return false;
        }

        const offset : number = (page - 1) * limit;
        return await Comment.find({ reportID, parentCommentID: null })
            .skip(offset)
            .limit(limit)
            .sort({ createdAt: -1 })
            .populate("createdBy", "username profilePic _id")
            .populate({
                path: "replies",
                populate: { path: "createdBy", select: "username profilePic _id" },
            });
    }

    async getCommentById(commentID: string) {
        return await Comment
            .findById(commentID)
            .populate("createdBy", "username profilePic _id")
            .populate({
                path: "replies",
                populate: { path: "createdBy", select: "username profilePic _id" },
            });;
    }

    async updateComment(commentID : string, updateData :Partial<IComment>) {

        const comment = await Comment.findById(commentID);
        if (!comment) {
            return null;
        }

        comment.modificationHistory.push({
            oldData: {
                content: comment.content,
                createdAt: comment.updatedAt
            },
            updatedAt: new Date(),
        });

        Object.assign(comment, updateData);
        await comment.save();
        return true;
    }

    async deleteCommentAndReplies(commentID : string, deletedBy : {role : string, id : string}) {
        const comment= await Comment.findById(commentID);
        if (!comment){
            return false;
        }
        console.log(deletedBy);

        const deletedByID = new mongoose.Types.ObjectId(deletedBy.id);
        console.log(deletedByID);

        const replies = await Comment.find({ parentCommentID: commentID });
        if (replies.length > 0) {
            const toTrash = replies.map((reply) => {
                return new trashComment({
                    ...reply.toObject(),
                    deletedBy: { role: deletedBy.role, hisID: deletedByID }
                });
            });
            await trashComment.insertMany(toTrash);
            await Comment.deleteMany({ parentCommentID: commentID });
        }
        
        const toTrash = new trashComment({...comment.toObject(), deletedBy : {role : deletedBy.role, hisID : deletedByID}});
        await toTrash.save();

        await comment.deleteOne();
        return true;
    }

    async getCommentReplies(commentID : string) {
        const comment = await Comment.findById(commentID);
        if (!comment) {
            return false;
        }
        
        return Comment
            .find({ parentCommentID : commentID})
            .populate("createdBy", "username profilePic _id");
    }

}
