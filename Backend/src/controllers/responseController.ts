import { Request, Response, NextFunction, response } from "express";
import asyncHandler from "express-async-handler";
import ResponseService from "../services/responseService";
import ApiError from "../utils/apiError";
import axios from "axios";


export default class ResponseController {

    constructor(private ResponseService: ResponseService) {
        this.getReportResponses = this.getReportResponses.bind(this);
        this.getResponseById = this.getResponseById.bind(this);
        this.createResponse = this.createResponse.bind(this);
        this.deleteResponse = this.deleteResponse.bind(this);
        this.voteResponse = this.voteResponse.bind(this);
        this.analysisResponse = this.analysisResponse.bind(this);
        this.verifyResponse = this.verifyResponse.bind(this);
        this.addResponseImages = this.addResponseImages.bind(this);
        this.deleteResponseImage = this.deleteResponseImage.bind(this);
        this.getLastResponseToReport = this.getLastResponseToReport.bind(this);
    }

    /**
     * @desc      Create Response on specific report
     * @route     POST /api/reports/:id/Response
     * @param     {string} id - Report id
     * @access    Public
    */
    createResponse = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const Response = await this.ResponseService.createResponse(req.params.id, req.body.user.id, req.files as Express.Multer.File[]);

        if (Response === 404) {
            return next(new ApiError("Report not found", 404));
        } else if (Response === 400) {
            return next(new ApiError("Report already resolved", 400));
        }
        
        res.status(201).json({ message: "Response added successfully", Response });
    });

    /**
     * @desc      Get report Responses
     * @route     GET /api/reports/:id/Response
     * @param     {string} id - Report id
     * @access    Private(Admin)
    */
    getReportResponses = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 6;
        const responses = await this.ResponseService.getReportResponses(page, limit, req.params.id);
        if(responses === false) {
            return next(new ApiError("Report not found", 404));
        } else {
            res.json({length: responses.length, page: page, responses: responses});
        }
        
    });

    /**    
     * @desc      Get last response to report
     * @route     GET /api/reports/:id/Response/last
     * @param     {string} id - Report id
     * @access    Public
    */
    getLastResponseToReport = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const response = await this.ResponseService.getLastResponseToReport(req.params.id);
        if(response === false) {
            return next(new ApiError("Report not found", 404));
        } else if(response === null) {
            return next(new ApiError("the report has no valid responses", 404))
        } else {
            res.json(response);
        }
    });

    /**
     * @desc      Get Response by id
     * @route     GET /api/Response/:id
     * @param     {string} id - Response id
     * @access    Public
    */
    getResponseById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const Response = await this.ResponseService.getResponseById(req.params.id);
        if (Response) {
            res.json(Response);
        } else {
            return next(new ApiError("Coupon not found", 404));
        }
    });

    /**
     * @desc      Delete Response
     * @route     DELETE /api/Responses/:id
     * @param     {string} id - Response id
     * @access    Private
    */
    deleteResponse = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { id, role } : {id: string, role: string} = req.body.user;
        const result = await this.ResponseService.deleteResponse(req.params.id, {role, id});
        if (result.status === 200) {
            res.json({ message: result.message });
        } else {
            return next(new ApiError(result.message, result.status));
        }
    });

    /**
     * @desc      Vote | Update vote | Delete
     * @route     POST /api/response/:id/vote
     * @param     {string} id - Response id
     * @access    Public
    */
    voteResponse = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.ResponseService.voteResponse(req.params.id, req.body.user.id, req.body.vote);
        if (result.status === 200) {
            res.json({ message: result.message});
        } else {
            return next(new ApiError(result.message, result.status));
        }
    });

    /**
     * @desc      add new image/s to response
     * @route     put /api/Response/:id/images
     * @param     {string} id - Response id
     * @access    Public
    */
    addResponseImages = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.ResponseService.addResponseImages(req.params.id, req.files as Express.Multer.File[]);
        if (result.status === 200) {
            res.json({ message: result.message });
        } else {
            return next(new ApiError(result.message, result.status));
        }
    });

    /**
     * @desc      remove image from response
     * @route     put /api/Response/:id/images
     * @param     {string} id - Response id
     * @access    Public
    */
    deleteResponseImage = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.ResponseService.deleteResponseImage(req.params.id, req.body.imageURL);
        if (result.status === 200) {
            res.json({ message: result.message });
        } else {
            return next(new ApiError(result.message, result.status));
        }
    })

    /**
     * @desc      Analysis response
     * @route     PUT /api/response/:id/analysis
     * @param     {string} id - Response id
     * @access    Public
    */
    analysisResponse = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const responseID = req.params.id;
        const result = await this.ResponseService.analysisResponse(responseID);
        if (result !== false) {
            res.json(result.return);
            if (result.return.action === 'care') {
                await axios.put(`http://localhost:5000/api/users/${result.return.user}/activity`, {
                    activity: 'care'
                    },{
                    headers: { 'Authorization': req.headers.authorization }
                });
            }
        } else {
            return next(new ApiError("Response is not verified", 400));
        }
    });


    /**
     * @desc      verify response
     * @route     PUT /api/response/:id/verify
     * @param     {string} id - Response id
     * @access    Public
    */
    verifyResponse = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const responseID = req.params.id;
        const result = await this.ResponseService.verifyResponse(responseID);
        if (result.status === 400) {
            return next(new ApiError(result.message, 400));
        } else {
            res.json(result);
        }
    });
}
