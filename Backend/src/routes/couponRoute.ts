import {Router} from "express";
import CouponService from "../services/couponService";
import CouponController from "../controllers/couponController";
import { verifyAdminMiddleware, verifyToken } from "../middlewares/authMiddleware";
import { getCouponValidator, redeemCouponCodeValidator, createCouponValidator, updateCouponValidator, deleteCouponValidator } from "../utils/validators/couponValidator";

const couponRouter = Router();

const couponService = new CouponService();
const { getCoupons,
        getAvailableCoupons,
        getCouponById, 
        redeemCoupon,
        createNewCoupons,
        updateCoupon,
        deleteCoupon} = new CouponController(couponService);

couponRouter.route('/')
        .get(verifyAdminMiddleware, getCoupons)
        .post(verifyAdminMiddleware, createCouponValidator, createNewCoupons);

couponRouter.route('/available')
        .get(verifyToken, getAvailableCoupons);

couponRouter.route('/:id')
        .get(verifyAdminMiddleware, getCouponValidator, getCouponById)
        .patch(verifyAdminMiddleware, updateCouponValidator, updateCoupon)
        .delete(verifyAdminMiddleware, deleteCouponValidator, deleteCoupon);

couponRouter.route('/:id/redeem')
        .get(verifyToken, redeemCouponCodeValidator, redeemCoupon);

export default couponRouter;