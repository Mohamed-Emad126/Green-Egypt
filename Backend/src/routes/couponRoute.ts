import {Router} from "express";
import CouponService from "../services/couponService";
import CouponController from "../controllers/couponController";
import { verifyAdminMiddleware } from "../middlewares/authMiddleware";
import { getCouponValidator, createCouponValidator, updateCouponValidator, deleteCouponValidator } from "../utils/validators/couponValidator";

const couponRouter = Router();

const couponService = new CouponService();
const { getCoupons, 
        getCouponById, 
        createNewCoupons,
        updateCoupon,
        deleteCoupon} = new CouponController(couponService);

couponRouter.route('/')
        .get(verifyAdminMiddleware, getCoupons)
        .post(verifyAdminMiddleware, createCouponValidator, createNewCoupons);

couponRouter.route('/:id')
        .get(verifyAdminMiddleware, getCouponValidator, getCouponById)
        .patch(verifyAdminMiddleware, updateCouponValidator, updateCoupon)
        .delete(verifyAdminMiddleware, deleteCouponValidator, deleteCoupon);

export default couponRouter;