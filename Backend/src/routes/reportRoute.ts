import { Router } from "express";
import ReportService from "../services/reportService";
import ReportController from "../controllers/reportController";
import { uploadImages } from "../middlewares/uploadImageMiddleware";
import { verifyToken, verifyReporterMiddleware } from "../middlewares/authMiddleware";
import { getReportValidator, 
        createReportValidator, 
        updateReportValidator, 
        uploadReportImagesValidator, 
        deleteReportImageValidator,
        deleteReportValidator, 
        toggleUpvoteValidator,
        registerVolunteeringValidator
        } from "../utils/validators/reportValidator";
import CommentController from "../controllers/commentController";
import CommentService from "../services/commentService";
import { createCommentValidator, getCommentsByReportValidator } from "../utils/validators/commentValidator";
import ResponseController from "../controllers/responseController";
import ResponseService from "../services/responseService";
import { createResponseValidator, getReportResponsesValidator } from "../utils/validators/responseValidator";

const reportRouter = Router();

const reportService = new ReportService();
const { 
        getReports, 
        getReportById, 
        createNewReport,
        updateReport,
        uploadReportImages,
        deleteReportImage,
        deleteReport,
        toggleUpvote,
        registerVolunteering
        } = new ReportController(reportService);

const commentService = new CommentService();
const { getCommentsByReport, createComment } = new CommentController(commentService);

const responseService = new ResponseService();
const { getReportResponses, createResponse } = new ResponseController(responseService);

reportRouter.route('/')
        .get(verifyToken, getReports)
        .post(verifyToken, uploadImages, createReportValidator, createNewReport);

reportRouter.route('/:id')
        .get(verifyToken, getReportValidator, getReportById)
        .patch(verifyReporterMiddleware, updateReportValidator, updateReport)
        .delete(verifyReporterMiddleware, deleteReportValidator, deleteReport)
        .put(verifyToken,registerVolunteeringValidator, registerVolunteering);

reportRouter.route('/:id/image')
        .patch(verifyReporterMiddleware, uploadImages, uploadReportImagesValidator, uploadReportImages)
        .delete(verifyReporterMiddleware, deleteReportImageValidator, deleteReportImage);

reportRouter.route('/:id/upvote')
        .patch(verifyToken, toggleUpvoteValidator, toggleUpvote);

reportRouter.route('/:id/comment')
        .get(verifyToken, getCommentsByReportValidator, getCommentsByReport)
        .post(verifyToken, createCommentValidator, createComment);      

reportRouter.route('/:id/response')
        .get(verifyToken, getReportResponsesValidator, getReportResponses)
        .post(verifyToken, uploadImages, createResponseValidator, createResponse);

export default reportRouter;