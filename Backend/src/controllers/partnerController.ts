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
        this.uploadPartnerLogo = this.uploadPartnerLogo.bind(this);
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
        const addByAdmin = req.body.user.id;
        await this.partnerService.createNewPartner({ partnerName, startDate, duration, durationUnit, website, description, addByAdmin}, req.file as Express.Multer.File);
        res.status(201).json({ message: "Partner created successfully"});
    });

    /**
     * @desc      Update partner
     * @route     PATCH /api/partners/:id
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
     * @route     DELETE /api/partners/:id/
     * @access    Private(Admin)
    */
    deletePartner = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {

        const options = {
            deleteCoupons: req.query.deleteCoupons === 'true',
            deleteFutureEvents: req.query.deleteFutureEvents === 'true',
            cancelFutureEvents: req.query.cancelFutureEvents === 'true'
        };

        let message = "Partner deleted successfully";
        if (options.deleteCoupons && options.deleteFutureEvents) {
            message = "Partner, its coupons and its future events deleted successfully";
        } else if (options.deleteCoupons) {
            message = "Partner and its coupons deleted successfully";
        } else if (options.deleteFutureEvents) {
            message = "Partner and its future events deleted successfully";
        }

        const deletedPartner = await this.partnerService.deletePartner(req.params.id, req.body.user.id, options);
        if (deletedPartner) {
            res.json({ message: message});
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
        if(!req.file) {
            return next(new ApiError("No file uploaded", 400));
        }
        const result = await this.partnerService.uploadPartnerLogo(req.params.id, req.file);
        if (result) {
            res.json({ message: "Logo updated successfully"});
        } else {
            return next(new ApiError("Partner not found", 404));
        }
    });

}