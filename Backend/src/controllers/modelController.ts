import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ModelService from "../services/modelService";
import ApiError from "../utils/apiError";

export default class ModelController {

    constructor(private ModelService: ModelService) {
        this.detectDisease = this.detectDisease.bind(this);
    }

    /**
     * @desc      send image for tree disease model
     * @route     POST /api/model/detect-disease
     * @access    Public
    */

    detectDisease = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {

        const prediction = await this.ModelService.detectTreeDisease(req.file!.path);

        if (prediction.status !== 200) {
            return next(new ApiError(prediction.error, prediction.status));
        }

        res.json({
            message: "Image processed successfully",
            data: prediction.data
        });
    });
}