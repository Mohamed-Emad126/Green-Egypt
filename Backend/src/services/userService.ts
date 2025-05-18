import { IUpdateInput, TUserActivity } from "../interfaces/iUser";
import User from "../models/userModel";
import mongoose from "mongoose";
import trashUser from "../models/trash/trashUserModel";
import bcrypt from "bcryptjs";
import fs from "fs";
import uploadToCloud from "../config/cloudinary";
import Tree from "../models/treeModel";
import Report from "../models/reportModel";
import Comment from "../models/commentModel";
import Response from "../models/responseModel";
import CommentService from "./commentService";
import ReportService from "./reportService";
import trashResponse from "../models/trash/trashResponseModel";




export default class UserService {
    async getUsers(page : number, limit : number, filters : any) {
        const offset : number = (page - 1) * limit;
        return await User.find(filters).skip(offset).limit(limit);
    }

    async getUserById(userID : string) {
        return await User.findById(userID).select("-password");
    }

    async updateUser(userID : string, updateData : IUpdateInput) {
        return await User.findByIdAndUpdate(
            userID,
            {$set: updateData},
            {new : true, runValidators : true}
        );
    }

    async changeUserPassword(userID : string, newPassword : string) {
        return await User.findByIdAndUpdate(userID, {password : await bcrypt.hash(newPassword, 10), passwordChangedAt : Date.now()}, {new : true, runValidators : true});
    }

    async deleteUser(userID : string, deletedBy : {role : string, id: string}) {
        const user = await User.findByIdAndUpdate(userID, {isActive : false}, {new : true, runValidators : true});
        if (!user){
            return false;
        }

        await this.deleteUserRelatedData(userID, deletedBy);
        
        const toTrash = new trashUser({...user.toObject(), deletedBy : {role : deletedBy.role, hisID : new mongoose.Types.ObjectId(deletedBy.id)}});
        await toTrash.save();

        await user.deleteOne();
        return true;
    }


    private async deleteUserRelatedData(userID: string, deletedBy: {role: string, id: string}) {

        const userReports = await Report.find({ createdBy: userID });
        const userReportIds = userReports.map(r => r._id);

        const reportService = new ReportService();
        await Promise.all(userReports.map(async (report) => {
            await reportService.deleteReportAndContent(report.id, deletedBy);
        }));
            
        
        const userComments = await Comment.find({ 
            createdBy: userID,
            reportID: { $nin: userReportIds }
        });
        
        const commentService = new CommentService();
        await Promise.all(userComments.map(async (comment) => {
            await commentService.deleteCommentAndReplies(comment.id, deletedBy);
        }));

        const userResponses = await Response.find({
            respondentID: userID,
            isVerified: false,
            reportID: { $nin: userReportIds }
        });

        if (userResponses.length > 0) {

            const toTrash = await Promise.all(userResponses.map(async (response) => {
                return new trashResponse({
                    ...response.toObject(),
                    deletedBy: { role: deletedBy.role, hisID: new mongoose.Types.ObjectId(deletedBy.id) }
                });
            }));
            await trashResponse.insertMany(toTrash);

            await Response.deleteMany({
                respondentID: userID,
                isVerified: false,
                reportID: { $nin: userReportIds }
            });
        }
    }

    async uploadUserPicture(userID: string, imageFile: any) {
        const user = await User.findById(userID);
        if (!user){
            return false;
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);

        user.profilePic = imageUploadResult.url;
        await user.save();
        fs.unlinkSync(imageFile.path);

        return true;
    }

    async deleteUserPicture(userID: string) {
        const user = await User.findById(userID);
        if (!user){
            return false;
        }

        if(user.profilePic !== '../uploads/default-user-avatar.png') {
            user.profilePic = '../uploads/default-user-avatar.png';
            await user.save();
        }

        return true;
    }

    async updateUserPoints(userID: string, activity: TUserActivity) {
        const user = await User.findById(userID);
        if (!user){
            return false;
        }

        let points = 0;
        let img= '';
        switch (activity) {
            case 'locate':
                points = 1;
                img = '../uploads/locate.png';
                break;
            case 'report':
                points = 5;
                img = '../uploads/report.png';
                break;
            case 'care':
                points = 20;
                img = '../uploads/care.png';
                break;
            case 'plant':
                points = 50;
                img = '../uploads/plant.png';
                break;
        }

        user.points += points;
        user.pointsHistory.push({ points, activity, date: new Date(), img });
        await user.save();

        // if (user.points >= 500) {
        //     const availableCoupon = await Coupon.findOne({ redeemed: false }).populate('brand');
    
        //     if (availableCoupon) {
        //         availableCoupon.redeemed = true;
        //         await availableCoupon.save();
    
        //         user.points -= 500;
        //         await user.save();
    
        //         return {
        //             message: `Congratulations ${user.username}! You have been rewarded with a coupon: ${availableCoupon.code}`,
        //             coupon: availableCoupon
        //         };
        //     } else {
        //         user.pendingCoupons += 1;
        //         user.points -= 500;
        //         await user.save();
        //         return {
        //             message: `Congratulations ${user.username}! You have earned a coupon but it's pending until new coupons are available, You will be notified when a coupon is available. You have ${user.pendingCoupons} pending coupon(s)`,
        //             coupon: null
        //         };
        //     }
        // }
    
        await user.save();
        return {
            message: `Points added successfully, current points: ${user.points}, keep going to earn coupons!`, 
            coupon: null
        };
    }

    // async claimPendingCoupons(userID: string) {
    //     const user = await User.findById(userID);
    //     if (!user) {
    //         return false;
    //     } else if (user.pendingCoupons === 0) {
    //         return {
    //             status: 400,
    //             message: "No pending coupons to claim.",
    //             coupon: null
    //         };
    //     }
    
    //     const availableCoupons = await Coupon.find({ redeemed: false }).limit(user.pendingCoupons).populate('brand');
    
    //     if (availableCoupons.length === 0) {
    //         return { 
    //             status: 400,
    //             message: "No available coupons to claim right now." ,
    //             coupon : null
    //         };
    //     }

    //     const claimedCoupons = [];
    //     for (let i = 0; i < availableCoupons.length; i++) {
    //         const coupon = availableCoupons[i];
    //         coupon.redeemed = true;
    //         await coupon.save();
    
    //         claimedCoupons.push(coupon);
    //     }
    
    //     user.pendingCoupons -= claimedCoupons.length;
    //     await user.save();
    
    //     return {
    //         status: 200,
    //         message: `${claimedCoupons.length} coupons claimed.`,
    //         coupon :claimedCoupons
    //     };
    // }

    async promoteUserToAdmin(userID: string) {
        const user = await User.findById(userID);

        if (!user) {
            return 'User not found.';
        }

        let msg = '';
        if (user.role === "user") {
            user.role = 'admin';
            msg = 'User promoted to admin successfully';
        } else {
            user.role = 'user';
            msg = 'User demoted to user successfully';
        }
        
        await user.save();
        return msg; 
    }

    async getUserTrees(userID: string) {
        const user = await User.findById(userID);
        if (!user) {
            return false;
        }
        const trees = await Tree.find({ byUser: user.id, plantedRecently: true });

        return trees;
    }

    async getUserPointsHistory(userID: string) {
        const user = await User.findById(userID);
        if (!user) {
            return false;
        }

        return user.pointsHistory;
    }

    async getUserSavedReports(userID: string) {
        const user = await User.findById(userID).populate("savedReports");
        if (!user) {
            return false;
        }

        return user.savedReports;
    }

}