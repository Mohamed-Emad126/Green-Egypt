import CouponService from "../services/couponService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";


export default class CouponController {

    constructor(private CouponService: CouponService) {
        this.getCoupons = this.getCoupons.bind(this);
        this.getCouponById = this.getCouponById.bind(this);
        this.createNewCoupons = this.createNewCoupons.bind(this);
        this.updateCoupon = this.updateCoupon.bind(this);
        this.deleteCoupon = this.deleteCoupon.bind(this);
    }

    /**
     * @desc      Get all coupons
     * @route     GET /api/coupons
     * @access    Private(Admin)
    */
    getCoupons = asyncHandler(async (req: Request, res: Response) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 5;
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        const Coupons = await this.CouponService.getCoupons(page, limit, filters);
        res.json({ length: Coupons.length, page: page, Coupons: Coupons });
    });

    /**
     * @desc      Get Coupon by id
     * @route     GET /api/Coupons/:id
     * @access    Private(Admin)
    */
    getCouponById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const Coupon = await this.CouponService.getCouponById(req.params.id);
        if (Coupon) {
            res.json(Coupon);
        } else {
            return next(new ApiError("Coupon not found", 404));
        }
    });

    /**
     * @desc      Create Coupon
     * @route     POST /api/Coupons
     * @access    Private(Admin)
    */
    createNewCoupons = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { codes, value, brand, expiryDate } = req.body;
        const addByAdmin = req.body.user.id
        const coupons = codes.map((code : string) => ({
            code,
            value,
            brand, 
            expiryDate,
            redeemed: false,
            addByAdmin
        }));
        await this.CouponService.createNewCoupons(coupons);
        res.status(201).json({ message: "Coupon created successfully"});
        
    });

    /**
     * @desc      Update Coupon
     * @route     patch /api/Coupons/:id
     * @access    Private(Admin)
    */
    updateCoupon = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const CouponAfterUpdate = await this.CouponService.updateCoupon(req.params.id, req.body);

        if (CouponAfterUpdate) {
            res.json({ message: "Coupon updated successfully"});
        } else {
            return next(new ApiError("Coupon not found", 404));
        }
        
    });

    /**
     * @desc      Delete Coupon
     * @route     DELETE /api/Coupons/:id
     * @access    Private(Admin)
    */
    deleteCoupon = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const deletedCoupon = await this.CouponService.deleteCoupon(req.params.id);
        if (deletedCoupon) {
            res.json({ message: "Coupon deleted successfully"});
        } else {
            return next(new ApiError("Coupon not found", 404));
        }

    });

}
