import { IUpdateInput, TUserActivity } from "../interfaces/iUser";
import User from "../models/userModel";
import Coupon from "../models/couponModel";
import trashUser from "../models/trash/trashUserModel";
import bcrypt from "bcryptjs";
import fs from "fs";
import uploadToCloud from "../config/cloudinary";

// TODO: add functionalities for redeem points to vouchers & reset points


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
                                            {username : updateData?.username, email : updateData?.email},
                                            {new : true, runValidators : true}
                                        );
    }

    async changeUserPassword(userID : string, newPassword : string) {
        return await User.findByIdAndUpdate(userID, {password : await bcrypt.hash(newPassword, 10), passwordChangedAt : Date.now()}, {new : true, runValidators : true});
    }

    async deleteUser(userID : string) {
        const user = await User.findByIdAndUpdate(userID, {isActive : false}, {new : true, runValidators : true});
        if (!user){
            return false;
        }
        
        const toTrash = new trashUser({...user.toObject()});
        await toTrash.save();

        await user.deleteOne();
        return true;
    }

    async uploadUserPicture(userID: string, imageFile: any) {
        const user = await User.findById(userID);
        if (!user){
            return false;
        }

        const imageUploadResult = await uploadToCloud(imageFile.path);

        user.profilePic = {
            imageName: imageFile.filename,
            imageUrl: imageUploadResult.url
        };
        await user.save();
        fs.unlinkSync(imageFile.path);

        return true;
    }

    async deleteUserPicture(userID: string) {
        const user = await User.findById(userID);
        if (!user){
            return false;
        }

        if(user.profilePic && user.profilePic.imageUrl !== '../uploads/userImages/default-user-avatar.png') {
            user.profilePic = { imageName: 'default-user-avatar.png', 
                                imageUrl: '../uploads/userImages/default-user-avatar.png' };
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
        switch (activity) {
            case 'locate':
                points = 1;
                break;
            case 'report':
                points = 5;
                break;
            case 'care':
                points = 20;
                break;
            case 'plant':
                points = 50;
                break;
        }

        user.points += points;

        if (user.points >= 500) {
            const availableCoupon = await Coupon.findOne({ redeemed: false }).populate('brand');
    
            if (availableCoupon) {
                availableCoupon.redeemed = true;
                await availableCoupon.save();
    
                user.points -= 500;
                await user.save();
    
                return {
                    message: `Congratulations ${user.username}! You have been rewarded with a coupon: ${availableCoupon.code}`,
                    coupon: availableCoupon
                };
            } else {
                user.pendingCoupons += 1;
                user.points -= 500;
                await user.save();
                return {
                    message: `Congratulations ${user.username}! You have earned a coupon but it's pending until new coupons are available, You will be notified when a coupon is available. You have ${user.pendingCoupons} pending coupon(s)`,
                    coupon: null
                };
            }
        }
    
        await user.save();
        return {
            message: `Points added successfully, current points: ${user.points}, keep going to earn a coupon!`, 
            coupon: null
        };
    }

    async claimPendingCoupons(userID: string) {
        const user = await User.findById(userID);
        if (!user) {
            return false;
        } else if (user.pendingCoupons === 0) {
            return { 
                message: "No pending coupons to claim.",
                coupon: null
            };
        }
    
        const availableCoupons = await Coupon.find({ redeemed: false }).limit(user.pendingCoupons).populate('brand');
    
        if (availableCoupons.length === 0) {
            return { 
                message: "No available coupons to claim right now." ,
                coupon : null
            };
        }

        const claimedCoupons = [];
        for (let i = 0; i < availableCoupons.length; i++) {
            const coupon = availableCoupons[i];
            coupon.redeemed = true;
            await coupon.save();
    
            claimedCoupons.push(coupon);
        }
    
        user.pendingCoupons -= claimedCoupons.length;
        await user.save();
    
        return {
            message: `${claimedCoupons.length} coupons claimed.`,
            coupon :claimedCoupons
        };
    }
}