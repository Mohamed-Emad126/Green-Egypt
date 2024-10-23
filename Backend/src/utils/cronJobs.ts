import cron from 'node-cron';
import Partner from '../models/partnerModel';
import trashPartner from '../models/trash/trashPartnerModel';
import Coupon from '../models/couponModel';
import trashCoupon from '../models/trash/trashCouponModel';

cron.schedule('0 0 * * *', async () => {
    const expiredPartners = await Partner.find({ endDate: { $lte: new Date() } });
    
    for (const partner of expiredPartners) {
        partner.hasExpired = true;
        await trashPartner.create({ ...partner.toObject() });
        await partner.deleteOne();
    }
});

cron.schedule('0 0 * * *', async () => {
    const now = new Date();
    const oneWeekFromNow = new Date();
    oneWeekFromNow.setDate(now.getDate() + 7); 

    const expiredCoupons = await Coupon.find({ expiryDate: { $lte: oneWeekFromNow } });

    for (const coupon of expiredCoupons) {
        await trashCoupon.create({ ...coupon.toObject() });
        await coupon.deleteOne();
    }
});
