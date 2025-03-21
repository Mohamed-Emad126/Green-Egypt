import cron from "node-cron";
import Partner from "../models/partnerModel";
import trashPartner from "../models/trash/trashPartnerModel";
import Coupon from "../models/couponModel";
import trashCoupon from "../models/trash/trashCouponModel";
import Token from "../models/tokenModel";
import Response from "../models/responseModel";
import Report from "../models/reportModel";
import ResponseService from "../services/responseService";

cron.schedule("0 0 * * *", async () => {
    try {
        console.log("Starting expired partners cleanup task...");
        const expiredPartners = await Partner.find({ endDate: { $lte: new Date() } });

        if (expiredPartners.length > 0) {
            await Promise.all(
                expiredPartners.map(async (partner) => {
                    partner.hasExpired = true;
                    await trashPartner.create({ ...partner.toObject() });
                    await partner.deleteOne();
                })
            );
        }

        console.log(`${expiredPartners.length} Expired partners cleanup task completed.`);
    } catch (error) {
        console.error("Error in expired partners cleanup task:", error);
    }
});


cron.schedule("5 0 * * *", async () => {
    try {
        console.log("Starting expired coupons cleanup task...");
        const now = new Date();
        const oneWeekFromNow = new Date();
        oneWeekFromNow.setDate(now.getDate() + 7);

        const expiredCoupons = await Coupon.find({ expiryDate: { $lte: oneWeekFromNow } });

        if (expiredCoupons.length > 0) {
            await Promise.all(
                expiredCoupons.map(async (coupon) => {
                    await trashCoupon.create({ ...coupon.toObject() });
                    await coupon.deleteOne();
                })
            );
        }

        console.log(`${expiredCoupons.length}Expired coupons cleanup task completed.`);
    } catch (error) {
        console.error("Error in expired coupons cleanup task:", error);
    }
});


cron.schedule("10 0 * * *", async () => {
    try {
        console.log("Starting expired tokens cleanup task...");
        await Token.deleteMany({ expiresAt: { $lte: new Date() } });
        
        console.log("Expired tokens cleanup task completed.");
    } catch (error) {
        console.error("Error in expired tokens cleanup task:", error);
    }
});

