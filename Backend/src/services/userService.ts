import { IUpdateInput, TUserActivity } from "../interfaces/iUser";
import User from "../models/userModel";
import bcrypt from "bcryptjs";
import fs from "fs";
import uploadToCloud from "../config/cloudinary";

// TODO: add functionalities for redeem points to vouchers & reset points


export default class UserService {
    async getUsers(page : number, limit : number) {
        const offset : number = (page - 1) * limit;
        return await User.find().skip(offset).limit(limit);
    }

    async getUserById(userID : string) {
        return await User.findById(userID).select("-password");
    }

    async updateUser(userID : string, updateData : IUpdateInput) {
        return await User.findByIdAndUpdate(userID, {
                                                        username : updateData?.username,
                                                        email : updateData?.email
                                                    }, {new : true, runValidators : true});
    }

    async changeUserPassword(userID : string, newPassword : string) {
        return await User.findByIdAndUpdate(userID, {password : await bcrypt.hash(newPassword, 10), passwordChangedAt : Date.now()}, {new : true, runValidators : true});
    }

    async deleteUser(userID : string) {
        return await User.findByIdAndDelete(userID);
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
                points = 10;
                break;
            case 'plant':
                points = 50;
                break;
        }

        user.points += points;
        await user.save();
        return user;
    }
}