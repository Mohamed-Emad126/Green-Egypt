import { ICoupon } from "../interfaces/iCoupon";
import Coupon from "../models/couponModel";
import trashCoupon from "../models/trash/trashCouponModel";
import fs from "fs";


export default class CouponService {
    async getCoupons(page : number, limit : number, filters : any) {
        const offset : number = (page - 1) * limit;
        return await Coupon.find(filters).skip(offset).limit(limit);
    }

    async getCouponById(couponID : string) {
        return await Coupon.findById(couponID);
    }

    async createNewCoupons(newCoupons : ICoupon[]) {
        return await Coupon.create(newCoupons);
    }

    async updateCoupon(couponID : string, updateData : ICoupon) {
        return await Coupon.findByIdAndUpdate(couponID, updateData, {new : true, runValidators : true});
    }

    async deleteCoupon(couponID : string) {
        const coupon = await Coupon.findById(couponID);
        if (!coupon){
            return false;
        }
        
        const toTrash = new trashCoupon({...coupon.toObject()});
        await toTrash.save();

        await coupon.deleteOne();
        return true;
    }
}