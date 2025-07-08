import { ICoupon, ICouponInput } from "../interfaces/iCoupon";
import Coupon from "../models/couponModel";
import trashCoupon from "../models/trash/trashCouponModel";
import Partner from "../models/partnerModel";
import mongoose from "mongoose";
import User from "../models/userModel";


export default class CouponService {
    async getCoupons(page : number, limit : number, filters : any) {
        const offset : number = (page - 1) * limit;
        return await Coupon.find(filters).skip(offset).limit(limit);
    }

    async getAvailableCoupons(userID : string, page : number, limit : number) {
        const user = await User.findById(userID);

        const offset : number = (page - 1) * limit;
        return await Coupon
            .find({cost : {$lte : user!.points}}, {brand : 1, value : 1, cost : 1})
            .skip(offset)
            .limit(limit)
            .populate("brand", "partnerName logo");
    }

    async getCouponById(couponID : string) {
        return await Coupon.findById(couponID);
    }

    async redeemCoupon(couponID : string, userID : string) {
        const coupon = await Coupon.findById(couponID).populate('brand', "partnerName logo");

        if (!coupon) {
            return { status : 404, message : "Coupon not found" };
        }

        const user = await User.findById(userID);
        if (!user!.points || user!.points < coupon.cost) {
            return { status : 400, message : "Not enough points" };
        }

        const userIDObjectId = new mongoose.Types.ObjectId(userID);
        const usedCode = coupon.codes.shift();
        coupon.usedCodes.push({
            user: userIDObjectId,
            code: usedCode!,
            redeemedAt: new Date()
        });
        await coupon!.save();


        user!.points -= coupon.cost;
        await user!.save();

        if (coupon.codes.length === 0) {
            await new trashCoupon({ ...coupon.toObject() }).save();
            await coupon.deleteOne();
        }

        return {
            brand: coupon.brand,
            code: usedCode,
            expiryDate: coupon.expiryDate,
            value: coupon.value,
            cost: coupon.cost 
        };
    }

    async createNewCoupons(newCoupons : ICouponInput) {
        const brand = await Partner.findById(newCoupons.brand);
        if (!brand) {
            return false;
        }

        return await Coupon.create(newCoupons);
    }

    async updateCoupon(couponID : string, updateData : ICouponInput) {
        const coupon = await Coupon.findById(couponID);
        if (!coupon) {
            return { status : 404, message : "Coupon not found" };
        }

        if (updateData.brand) {
            const brand = await Partner.findById(updateData.brand);
            if (!brand) {
                return { status : 404, message : "Brand not found" };
            }
        }
        
        if (updateData.codes) {
            const totalCoupons = [...coupon.codes, ...updateData.codes];
            updateData.codes = [...new Set(totalCoupons)];
        }
        
        if (updateData.addByAdmin) {
            return { status : 400, message : "Cannot update addByAdmin field" };
        }

        Object.assign(coupon, updateData);
        await coupon.save();
        
        return { status : 200, message : "Coupon updated successfully", coupon: coupon };
    }

    async deleteCoupon(couponID : string, deletedBy : string) {
        const coupon = await Coupon.findById(couponID);
        if (!coupon){
            return false;
        }
        
        const toTrash = new trashCoupon({...coupon.toObject(), deletedBy : new mongoose.Types.ObjectId(deletedBy)});
        await toTrash.save();

        await coupon.deleteOne();
        return true;
    }
}