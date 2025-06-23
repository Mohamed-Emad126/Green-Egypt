import { Request, Response, NextFunction } from "express";
import asyncHandler from "express-async-handler";
import ObjectDetectionService from "../services/OdModelService";
import ApiError from "../utils/apiError";

export default class ObjectDetectionController {

    constructor(private service: ObjectDetectionService) {
        this.detectObjects = this.detectObjects.bind(this);
    }

    /**
     * @desc      send image for object detection model
     * @route     POST /api/object/detect-objects
     * @access    Public
     */


    detectObjects = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const prediction = await this.service.detectObjects(req.file!.path);

        if (prediction.status !== 200) {
            return next(new ApiError(prediction.error, prediction.status));
        }

        res.json({
            message: "Object detection completed successfully",
            data: prediction.data
        });
    });
}