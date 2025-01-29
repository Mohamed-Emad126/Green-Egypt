import { IComment } from "../interfaces/iComment";
import Comment from "../models/commentModel";
import trashComment from "../models/trash/trashCommentModel";
import Report from "../models/reportModel";


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

    async getCommentsByReport(reportID: string) {
        const report = await Report.findById(reportID);
        if(!report) {
            return false;
        }

        return await Comment.find({ reportID, parentCommentID: null })
            .sort({ createdAt: -1 })
            .populate("createdBy")
            .populate({
                path: "replies",
                populate: { path: "createdBy" },
            });
    }

    async getCommentById(commentID: string) {
        return await Comment.findById(commentID).populate("createdBy").populate("reportID");
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

    async deleteComment(commentID : string) {
        const comment= await Comment.findById(commentID);
        if (!comment){
            return false;
        }
        
        const toTrash = new trashComment({...comment.toObject()});
        await toTrash.save();

        await comment.deleteOne();
        return true;
    }

    async getCommentReplies(commentID : string) {
        const comment = await Comment.findById(commentID);
        if (!comment) {
            return false;
        }
        
        return Comment.find({ parentCommentID : commentID});
    }

}
