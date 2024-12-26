import { IComment } from "../interfaces/iComment";
import Comment from "../models/commentModel";
import trashComment from "../models/trash/trashCommentModel";

export default class CommentService {

    async createComment(data: Partial<IComment>) {
        return await Comment.create(data);
    }

    async getCommentsByReport(reportID: string) {
        return await Comment.find({ reportID }).sort({ createdAt: -1 }).populate("createdBy");
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
                createdAt: comment.id.getTimestamp()
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
}
