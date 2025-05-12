import cron from "node-cron";
import Partner from "../models/partnerModel";
import trashPartner from "../models/trash/trashPartnerModel";
import Coupon from "../models/couponModel";
import trashCoupon from "../models/trash/trashCouponModel";
import Token from "../models/tokenModel";
import Response from "../models/responseModel";
import Report from "../models/reportModel";


cron.schedule("0 0 * * *", async () => {
    try {
        console.log("Starting expired partners cleanup task...");

        const expiredPartners = await Partner.find({ endDate: { $lte: new Date() } });
        let deletedCount = 0;

        for (const partner of expiredPartners) {
            const activeCoupons = await Coupon.find({ brand: partner._id});
            if (activeCoupons.length > 0) {
                console.log(`Skipped ${partner.partnerName} — still has unredeemed coupons`);
                continue;
            }

            partner.hasExpired = true;
            await trashPartner.create({ ...partner.toObject() });
            await partner.deleteOne();
            deletedCount++;
        }

        if (deletedCount === 0) {
            console.log("No expired partners deleted");
        } else {
            console.log(`${deletedCount} expired partners deleted successfully`);
        }

    } catch (error) {
        console.error("Error in expired partners cleanup task:", error);
    }
});


cron.schedule("0 5 * * *", async () => {
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

        console.log(`${expiredCoupons.length} Expired coupons cleanup task completed.`);
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

cron.schedule("15 0 * * *", async () => {
    try {
        console.log("Starting expired volunteering cleanup task...");

        const now = new Date();
        const threeDaysAgo = new Date(now);
        threeDaysAgo.setDate(now.getDate() - 3);
        threeDaysAgo.setHours(0, 0, 0, 0);
        const endOfThreeDaysAgo = new Date(threeDaysAgo);
        endOfThreeDaysAgo.setHours(23, 59, 59, 999);
        
        const reportsWithExpiredVolunteering = await Report.find({
            "volunteering.at": { $gte: threeDaysAgo, $lte: endOfThreeDaysAgo }
        });

        if (reportsWithExpiredVolunteering.length > 0) {
            await Promise.all(
                reportsWithExpiredVolunteering.map(async (report) => {
                    report.volunteering = { volunteer: null, at: null };
                    report.status = "Pending";
                    await report.save();
                })
            );
        }
        
        console.log("Expired volunteering cleanup task completed.");
    } catch (error) {
        console.error("Error in expired volunteering cleanup task:", error);
    }
});

cron.schedule("20 0 * * *", async () => {
    try {
        console.log("Starting verified responses cleanup task...");

        const now = new Date();
        const sevenDaysAgo = new Date(now);
        sevenDaysAgo.setDate(now.getDate() - 7);
        sevenDaysAgo.setHours(0, 0, 0, 0);
        const endOfSevenDaysAgo = new Date(sevenDaysAgo);
        endOfSevenDaysAgo.setHours(23, 59, 59, 999);

        const responses7DaysAgo = await Response.find({
            createdAt: { $gte: sevenDaysAgo, $lte: endOfSevenDaysAgo }
        });

        if (responses7DaysAgo.length > 0) {
            await Promise.all(
                responses7DaysAgo.map(async (response) => {
                    const report = await Report.findById(response.reportID);
                    const upVotes = response.upVotes;
                    const downVotes = response.downVotes;
                    if (upVotes > downVotes && upVotes >= 5) {
                        if(report!.status !== "Resolved") {
                            response.isVerified = true;
                            response.note = {
                                message: "Request an analysis of your response to get your reward",
                                status: "accepted"
                            };

                            report!.status = "Resolved";
                            report!.upVotes = Math.floor(report!.upVotes * 0.8);
                            await report!.save();
                        } else {
                            response.note = {
                                message: "Response has been accepted but the report is already resolved",
                                status: "accepted but rejected"
                            };
                        }

                        await response.save();
                    } else {
                        response.note = {
                            message: "Try again, Share with others to get more up votes or just unsave the report",
                            status: "rejected"
                        };
                        await response.save();

                        const filteredResponses = await Response.find({
                            reportID: report!.id,    
                            note: null
                        });

                        if (filteredResponses.length === 0) {
                            report!.status = "Pending";
                            await report!.save();
                        }
                    }
                })
            );
        }

        console.log(`Verified ${responses7DaysAgo.length} responses cleanup task completed.`);

    } catch (error) {
        console.error("Error in verified responses cleanup task:", error);
    }
});

