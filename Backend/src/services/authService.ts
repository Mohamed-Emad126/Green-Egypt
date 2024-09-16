import { IUser, IUserInput } from "../interfaces/iUser";
import User from "../models/userModel";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

export default class AuthService {

    async createNewUser(newUser : IUserInput) : Promise<boolean> {
        const findUser = await User.findOne({email: newUser.email});
        if(findUser) {
            return false;
        } else {
            const user = new User({username: newUser.username, email: newUser.email, password: await bcrypt.hash(newUser.password, 10)});
            await user.save();
            return true;
        }
    }

    async login(userData : IUserInput): Promise<string | null | boolean> {
        const findUser = await User.findOne({email: userData.email});
        if(!findUser) {
            return false;
        } else {
            const isPasswordMatch = await bcrypt.compare(userData.password, findUser.password);
            if(isPasswordMatch) {
                const token = jwt.sign({id : findUser.id}, process.env.JWT_SECRET as string);
                return token;
            }else{
                return null;
            } 
        } 
    }
}

