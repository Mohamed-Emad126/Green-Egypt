import { Router } from "express";
import ReportService from "../services/reportService";
import ReportController from "../controllers/reportController";
import { uploadImages } from "../middlewares/uploadImageMiddleware";
import { verifyToken, verifyReporterMiddleware } from "../middlewares/authMiddleware";
import { getReportValidator, createReportValidator, updateReportValidator, uploadReportImagesValidator, deleteReportImageValidator, deleteReportValidator, toggleUpvoteValidator } from "../utils/validators/reportValidator";

const reportRouter = Router();

const reportService = new ReportService();
const { getReports, 
        getReportById, 
        createNewReport,
        updateReport,
        uploadReportImages,
        deleteReportImage,
        deleteReport,
        toggleUpvote} = new ReportController(reportService);

reportRouter.route('/')
        .get(verifyToken, getReports)
        .post(verifyToken, createReportValidator, createNewReport);

reportRouter.route('/:id')
        .get(verifyToken, getReportValidator, getReportById)
        .patch(verifyReporterMiddleware, updateReportValidator, updateReport)
        .delete(verifyReporterMiddleware, deleteReportValidator, deleteReport);

reportRouter.route('/:id/image')
        .patch(verifyReporterMiddleware, uploadImages, uploadReportImagesValidator, uploadReportImages)
        .delete(verifyReporterMiddleware, deleteReportImage);

reportRouter.route('/:id/upvote')
        .patch(verifyToken, toggleUpvoteValidator, toggleUpvote);

export default reportRouter;