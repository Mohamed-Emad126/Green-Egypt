import { Router } from "express";
import ReportService from "../services/reportService";
import ReportController from "../controllers/reportController";
import { uploadImages } from "../middlewares/uploadImageMiddleware";
import { verifyToken, verifyReporterMiddleware } from "../middlewares/authMiddleware";
import { getAllReportsValidator,
        getReportValidator, 
        createReportValidator, 
        updateReportValidator, 
        uploadReportImagesValidator, 
        deleteReportImageValidator,
        deleteReportValidator, 
        toggleUpvoteValidator,
        registerVolunteeringValidator,
        saveReportValidator } from "../utils/validators/reportValidator";
import CommentController from "../controllers/commentController";
import CommentService from "../services/commentService";
import { createCommentValidator, getCommentsByReportValidator } from "../utils/validators/commentValidator";
import ResponseController from "../controllers/responseController";
import ResponseService from "../services/responseService";
import { createResponseValidator, getReportResponsesValidator, getLastResponseToReportValidator } from "../utils/validators/responseValidator";

const reportRouter = Router();

const reportService = new ReportService();
const { 
        getReports, 
        getReportById, 
        createNewReport,
        updateReport,
        uploadReportImages,
        deleteReportImage,
        deleteReportAndContent,
        toggleUpvote,
        registerVolunteering,
        saveReport
        } = new ReportController(reportService);

const commentService = new CommentService();
const { getCommentsByReport, createComment } = new CommentController(commentService);

const responseService = new ResponseService();
const { getReportResponses, getLastResponseToReport, createResponse } = new ResponseController(responseService);

reportRouter.route('/')
        .get(verifyToken, getAllReportsValidator, getReports)
        .post(verifyToken, uploadImages, createReportValidator, createNewReport);

reportRouter.route('/:id')
        .get(verifyToken, getReportValidator, getReportById)
        .patch(verifyReporterMiddleware, updateReportValidator, updateReport)
        .delete(verifyReporterMiddleware, deleteReportValidator, deleteReportAndContent)
        .put(verifyToken, registerVolunteeringValidator, registerVolunteering);

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

reportRouter.route('/:id/response/last')
        .get(verifyToken, getLastResponseToReportValidator, getLastResponseToReport);

reportRouter.route('/:id/save')
        .put(verifyToken, saveReportValidator, saveReport);

export default reportRouter;