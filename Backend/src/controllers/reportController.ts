import ReportService from "../services/reportService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { IReportInput } from "../interfaces/iReport";


export default class ReportController {

    constructor(private reportService: ReportService) {
        this.getReports = this.getReports.bind(this);
        this.getReportById = this.getReportById.bind(this);
        this.createNewReport = this.createNewReport.bind(this);
        this.updateReport = this.updateReport.bind(this);
        this.deleteReport = this.deleteReport.bind(this);
        this.toggleUpvote = this.toggleUpvote.bind(this);
        this.deleteReportImage = this.deleteReportImage.bind(this);
        this.uploadReportImages = this.uploadReportImages.bind(this);
        this.registerVolunteering = this.registerVolunteering.bind(this);
        this.saveReport = this.saveReport.bind(this);
    }

    /**
     * @desc      Get all reports
     * @route     GET /api/reports
     * @access    Public
    */
    getReports = asyncHandler(async (req: Request, res: Response) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 5;
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        const reports = await this.reportService.getReports(page, limit , filters);
        res.json({ length: reports.length, page: page, reports: reports });
    });

    /**
     * @desc      Get report by id
     * @route     GET /api/reports/:id
     * @access    Public
    */
    getReportById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const report = await this.reportService.getReportById(req.params.id);
        if (report) {
            res.json(report);
        } else {
            return next(new ApiError("Report not found", 404));
        }
    });

    /**
     * @desc      Create new report
     * @route     POST /api/reports
     * @access    Public
    */
    createNewReport = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        let { location } = req.body;
        location = JSON.parse(location);
        const createdReport = await this.reportService.createNewReport({ ...req.body, createdBy: req.body.user.id , location }, req.files as Express.Multer.File[]);
        if (createdReport) {
            res.status(201).json({ message: 'Report created successfully' });
        } else {
            return next(new ApiError("Tree not found", 404));
        }
    });

    /**
     * @desc      Update report
     * @route     PATCH /api/reports/:id
     * @access    Public
    */
    updateReport = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const ReportAfterUpdate = await this.reportService.updateReport(req.params.id, req.body);
        if (ReportAfterUpdate === true) {
            res.json({ message: "Report updated successfully"});
        } else {
            return next(new ApiError(ReportAfterUpdate, 404));
        }
        
    });

    /**
     * @desc      Upload report images
     * @route     POST /api/reports/:id/image
     * @access    Private
    */
    uploadReportImages = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.reportService.uploadReportImages(req.params.id, req.files as Express.Multer.File[]);
        if (result) {
            res.json({ message: "Images uploaded successfully"});
        } else {
            return next(new ApiError("Report not found", 404));
        }
    });

    /**
     * @desc      Delete specific image from report
     * @route     DELETE /api/reports/:id/image
     * @access    Private
    */
    deleteReportImage = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.reportService.deleteImage(req.params.id, req.body.imagePath);
        if (result === true) {
            res.json({ message: "Image deleted successfully"});
        } else {
            return next(new ApiError(result, 404));
        }
    });

    /**
     * @desc      Delete Report
     * @route     DELETE /api/reports/:id
     * @access    Private
    */
    deleteReport = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const deletedReport = await this.reportService.deleteReport(req.params.id);
        if (deletedReport) {
            res.json({ message: "Report deleted successfully"});
        } else {
            return next(new ApiError("Report not found", 404));
        }
    });

    /** 
     * @desc      add upvote or delete upvote
     * @route     PATCH /api/reports/:id/upvote
     * @access    Public
    */
    toggleUpvote = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const upVoteResult = await this.reportService.toggleUpvote(req.params.id, req.body.user.id);
        if (upVoteResult){
            res.json({message: upVoteResult});
        } else {
            return next(new ApiError("Report not found", 404));
        }
    });

    /**
     * @desc      Register volunteering
     * @route     PUT /api/reports/:id/volunteer
     * @access    Public
    */
    registerVolunteering = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.reportService.registerVolunteering(req.params.id, req.body.user.id);
        if (result.status === 200) {
            res.json({ message: result.message });
        } else {
            return next(new ApiError(result.message, result.status));
            
        }
    });

    /**
     * @desc      Save report
     * @route     PUT /api/reports/:id/save
     * @access    Public
    */
    saveReport = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.reportService.saveReport(req.params.id, req.body.user.id);
        if (result) {
            res.json({ message: result});
        } else {
            return next(new ApiError("Report not found", 404));
        }
    });
}
