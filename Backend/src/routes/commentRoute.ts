import { Router } from "express";
import { verifyToken, verifyCommenterMiddleware } from "../middlewares/authMiddleware";
import CommentController from "../controllers/commentController";
import CommentService from "../services/commentService";
import { getCommentByIdValidator, updateCommentValidator, deleteCommentValidator, getCommentRepliesValidator } from "../utils/validators/commentValidator";

const commentRouter = Router();

const commentService = new CommentService();
const { getCommentById , updateComment, deleteComment, getCommentReplies} = new CommentController(commentService);

commentRouter.route('/:id')
    .get(verifyToken, getCommentByIdValidator, getCommentById)
    .patch( verifyCommenterMiddleware, updateCommentValidator, updateComment)
    .delete(verifyCommenterMiddleware, deleteCommentValidator, deleteComment);

commentRouter.route('/:id/replies')
    .get(verifyToken, getCommentRepliesValidator, getCommentReplies);

export default commentRouter;