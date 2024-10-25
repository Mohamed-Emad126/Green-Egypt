import PartnerService from "../services/partnerService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { IPartnerInput } from "../interfaces/iPartner";


export default class PartnerController {

    constructor(private partnerService: PartnerService) {
        this.getPartners = this.getPartners.bind(this);
        this.getPartnerById = this.getPartnerById.bind(this);
        this.createNewPartner = this.createNewPartner.bind(this);
        this.updatePartner = this.updatePartner.bind(this);
        this.deletePartner = this.deletePartner.bind(this);
    }

    /**
     * @desc      Get all partners
     * @route     GET /api/partners
     * @access    Public
    */
    getPartners = asyncHandler(async (req: Request, res: Response) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 5;
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        const partners = await this.partnerService.getPartners(page, limit, filters);
        res.json({ length: partners.length, page: page, partners: partners });
    });

    /**
     * @desc      Get partner by id
     * @route     GET /api/partners/:id
     * @access    Public
    */
    getPartnerById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const partner = await this.partnerService.getPartnerById(req.params.id);
        if (partner) {
            res.json(partner);
        } else {
            return next(new ApiError("Partner not found", 404));
        }
    });

    /**
     * @desc      Create partner
     * @route     POST /api/partners
     * @access    Private(Admin)
    */
    createNewPartner = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { partnerName, startDate, duration, durationUnit, website = "No website", description } : IPartnerInput = req.body;
        await this.partnerService.createNewPartner({ partnerName, startDate, duration, durationUnit, website, description });
        res.status(201).json({ message: "Partner created successfully"});
        
    });

    /**
     * @desc      Update partner
     * @route     patch /api/partners/:id
     * @access    Private(Admin)
    */
    updatePartner = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const partnerAfterUpdate = await this.partnerService.updatePartner(req.params.id, req.body);

        if (partnerAfterUpdate) {
            res.json({ message: "Partner updated successfully"});
        } else {
            return next(new ApiError("Partner not found", 404));
        }
        
    });

    /**
     * @desc      Delete partner
     * @route     DELETE /api/partners/:id
     * @access    Private(Admin)
    */
    deletePartner = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const deletedPartner = await this.partnerService.deletePartner(req.params.id);
        if (deletedPartner) {
            res.json({ message: "Partner deleted successfully"});
        } else {
            return next(new ApiError("Partner not found", 404));
        }

    });

    /**
     * @desc      Upload partner picture
     * @route     post /api/partners/:id/image
     * @access    Private(Admin)
    */
    uploadPartnerLogo = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.partnerService.uploadPartnerLogo(req.params.id, req.file);
        if (result) {
            res.json({ message: "Logo updated successfully"});
        } else {
            return next(new ApiError("Partner not found", 404));
        }
    });

}
