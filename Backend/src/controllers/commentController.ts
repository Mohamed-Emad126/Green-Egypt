import { Request, Response, NextFunction } from "express";
import asyncHandler from "express-async-handler";
import CommentService from "../services/commentService";
import ApiError from "../utils/apiError";



export default class CommentController {

    constructor(private CommentService: CommentService) {
        this.getCommentsByReport = this.getCommentsByReport.bind(this);
        this.getCommentById = this.getCommentById.bind(this);
        this.createComment = this.createComment.bind(this);
        this.updateComment = this.updateComment.bind(this);
        this.deleteComment = this.deleteComment.bind(this);
    }

    /**
     * @desc      Create comment on specific report
     * @route     post /api/reports/:id/comment
     * @param     {string} id - Report id
     * @access    Public
    */
    createComment = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { reportID, createdBy, content } = req.body;
        const comment = await this.CommentService.createComment({ reportID, createdBy, content });
        res.status(201).json({ message: "Comment added successfully", comment });
    });

    /**
     * @desc      Get report's comments
     * @route     get /api/reports/:id/comment
     * @param     {string} id - Report id
     * @access    Public
    */
    getCommentsByReport = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const reportID = req.params.id;

        if (!reportID) {
            return next(new ApiError("Report ID is required", 400));
        }
        const comments = await this.CommentService.getCommentsByReport(reportID);
        res.status(200).json({ comments });
    });

    /**
     * @desc      Get Comment by id
     * @route     GET /api/Comment/:id
     * @param     {string} id - Comment id
     * @access    Private(Admin)
    */
    getCommentById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const comment = await this.CommentService.getCommentById(req.params.id);
        if (comment) {
            res.json(comment);
        } else {
            return next(new ApiError("Coupon not found", 404));
        }
    });

    /**
     * @desc      Update comment
     * @route     patch /api/comments/:id
     * @param     {string} id - Comment id
     * @access    Private
    */
    updateComment = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {

        const commentAfterUpdate = await this.CommentService.updateComment(req.params.id, req.body);
        if (commentAfterUpdate) {
            res.json({ message: "Comment updated successfully"});
        } else {
            return next(new ApiError('Comment not found', 404));
        }
        
    });

    /**
     * @desc      Delete comment
     * @route     delete /api/comments/:id
     * @param     {string} id - Comment id
     * @access    Private
    */
    deleteComment = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const commentAfterDelete = await this.CommentService.deleteComment(req.params.id);
        if (commentAfterDelete) {
            res.json({ message: "Comment deleted successfully"});
        } else {
            return next(new ApiError('Comment not found', 404));
        }
    });
}
