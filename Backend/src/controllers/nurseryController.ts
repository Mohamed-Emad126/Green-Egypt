import NurseryService from "../services/nurseryService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { INurseryInput } from "../interfaces/iNursery";


export default class NurseryController {

    constructor(private nurseryService: NurseryService) {
        this.getNurseries = this.getNurseries.bind(this);
        
    }

    /**
     * @desc      Get all nurseries
     * @route     GET /api/nursery
     * @access    Public
    */

    getNurseries = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 5;
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        const nurseries = await this.nurseryService.getNurseries(page, limit , filters);
        res.json({ length: nurseries.length, page: page, nurseries: nurseries });
});

    /**
     * @desc      Get nursery by id
     * @route     GET /api/nursery/:id
     * @access    Public
     */

    getNurseryById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const nursery = await this.nurseryService.getNurseryById(req.params.id);
            if (nursery) {
                res.json(nursery);
            } else {
                return next(new ApiError("nursery not found", 404));
        }
    });

    /**
     * @desc      Create nursery
     * @route     POST /api/nursery
     * @access    Public
     */
    createNursery = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const {nurseryname,nurseryPic,location}: INurseryInput = req.body;
        const nursery = await this.nurseryService.createNursery({nurseryname,nurseryPic,location});
        if (nursery) {
            res.json({ message: 'nursery created successfully' });
        } else {
            return next(new ApiError("Error creating nursery", 500));
        }
    });

    /**
     * @desc      Update nursery
     * @route     PATCH /api/nursery/:id
     * @access    Public
     */

    updateNursery = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const nusrseryAfterUpdate = await this.nurseryService.updateNursery(req.params.id, req.body);
        if (nusrseryAfterUpdate) {
            res.json({ message: 'nursery updated successfully' });
        } else {
            return next(new ApiError("nursery not found", 404));
        }
    });

    /**
     * @desc      Delete nursery
     * @route     DELETE /api/nursery/:id
     * @access    Public
     */

    deleteNursery = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const nursery = await this.nurseryService.deleteNursery(req.params.id);
        if (nursery) {
            res.json({ message: 'Nursery deleted successfully' });
        } else {
            return next(new ApiError("Nursery not found", 500));
        }
    });

    /**
     * @desc      Upload nursery picture
     * @route     POST /api/nursery/:id/picture
     * @access    Puiblic
     */
    uploadNurseryPicture = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.nurseryService.uploadNurseryPicture(req.params.id, req.file);
        if (result) {
            res.json({ message: "Picture updated successfully"});
        } else {
            return next(new ApiError("Nursery not found", 404));
        }
    });

}