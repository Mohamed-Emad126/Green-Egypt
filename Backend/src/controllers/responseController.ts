import { Request, Response, NextFunction, response } from "express";
import asyncHandler from "express-async-handler";
import ResponseService from "../services/responseService";
import ApiError from "../utils/apiError";



export default class ResponseController {

    constructor(private ResponseService: ResponseService) {
        this.getReportResponses = this.getReportResponses.bind(this);
        this.getResponseById = this.getResponseById.bind(this);
        this.createResponse = this.createResponse.bind(this);
        this.deleteResponse = this.deleteResponse.bind(this);
        this.voteResponse = this.voteResponse.bind(this);
    }

    /**
     * @desc      Create Response on specific report
     * @route     POST /api/reports/:id/Response
     * @param     {string} id - Report id
     * @access    Public
    */
    createResponse = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const Response = await this.ResponseService.createResponse(req.params.id, req.body.userID, req.files as Express.Multer.File[]);

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
     * @access    Public
    */
    getReportResponses = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const responses = await this.ResponseService.getReportResponses(req.params.id);
        if(responses === false) {
            return next(new ApiError("Report not found", 404));
        } else {
            res.json({ responses });
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
        const ResponseAfterDelete = await this.ResponseService.deleteResponse(req.params.id);
        if (ResponseAfterDelete) {
            res.json({ message: "Response deleted successfully"});
        } else {
            return next(new ApiError('Response not found', 404));
        }
    });

    /**
     * @desc      Vote | Update vote | Delete
     * @route     POST /api/response/:id/vote
     * @param     {string} id - Response id
     * @access    Public
    */
    voteResponse = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.ResponseService.voteResponse(req.params.id, req.body.userID, req.body.vote);
        if (result) {
            res.json({ message: result});
        } else {
            return next(new ApiError('Response not found', 404));
        }
    });
}
