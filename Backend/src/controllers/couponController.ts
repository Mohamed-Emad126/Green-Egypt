import CouponService from "../services/couponService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { ICouponInput } from "../interfaces/iCoupon";


export default class CouponController {

    constructor(private CouponService: CouponService) {
        this.getCoupons = this.getCoupons.bind(this);
        this.getAvailableCoupons = this.getAvailableCoupons.bind(this);
        this.redeemCoupon = this.redeemCoupon.bind(this);
        this.getCouponById = this.getCouponById.bind(this);
        this.createNewCoupons = this.createNewCoupons.bind(this);
        this.updateCoupon = this.updateCoupon.bind(this);
        this.deleteCoupon = this.deleteCoupon.bind(this);
    }

    /**
     * @desc      Get all coupons by filters for admins
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
     * @desc      Get all available coupons for users
     * @route     GET /api/coupons/available
     * @access    Public
    */
    getAvailableCoupons = asyncHandler(async (req: Request, res: Response) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 5;
        const coupons = await this.CouponService.getAvailableCoupons(req.body.user.id, page, limit);

        if (coupons.length === 0) {
            res.json({ message: 'Points not enough, please earn at least 50 points' });
        } else {
            res.json({ length: coupons.length, page: page, coupons: coupons });
        }
    })

    /**
     * @desc      Get Coupon by id
     * @route     GET /api/Coupons/:id
     * @param     {string} id - Coupon id
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
     * @desc      Redeem Coupon code
     * @route     POST /api/Coupons/:id/redeem
     * @param     {string} id - Coupon id
     * @access    Private(User)
    */
    redeemCoupon = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.CouponService.redeemCoupon(req.params.id, req.body.user.id);
        if (result.status) {
            return next(new ApiError(result.message, result.status));
        } else {
            res.json({ message: "Coupon redeemed successfully", redeemed_coupon: result });
        }   
    })

    /**
     * @desc      Create Coupon
     * @route     POST /api/Coupons
     * @access    Private(Admin)
    */
    createNewCoupons = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { codes, value, brand, cost, expiryDate } : ICouponInput  = req.body;
        const addByAdmin = req.body.user.id
        
        const result = await this.CouponService.createNewCoupons({ codes, value, brand, cost, expiryDate, addByAdmin });

        if (!result) {
            return next(new ApiError("Brand not found", 404));
        }

        res.status(201).json({ message: "Coupon created successfully"});
    });

    /**
     * @desc      Update Coupon
     * @route     patch /api/Coupons/:id
     * @access    Private(Admin)
    */
    updateCoupon = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.CouponService.updateCoupon(req.params.id, req.body);

        if (result.status !== 200) {
            return next(new ApiError(result.message, result.status));
        }
        
        res.json({ message: result.message, coupon: result.coupon });
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
