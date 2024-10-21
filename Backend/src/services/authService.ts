import { IAuthInput } from "../interfaces/iUser";
import User from "../models/userModel";
import Token from "../models/tokenModel";
import bcrypt from "bcryptjs";

import  sendEmail from "../utils/email";
import jwt from "jsonwebtoken";
import { OAuth2Client } from "google-auth-library";
import { token } from "morgan";


export default class AuthService {
    async createNewUser(newUser: IAuthInput): Promise<string | boolean> {
    const user = new User({
    username: newUser.username,
    email: newUser.email,
    password: await bcrypt.hash(newUser.password, 10),
    });
    await user.save();

    const token = user.generateToken();
    await new Token({ token: token }).save();

    return token;
    }

    async login(userData: IAuthInput): Promise<string | boolean> {
    const findUser = await User.findOne({ email: userData.email });
    if (!findUser ||!(await bcrypt.compare(userData.password, findUser.password))) {
        return false;
    }

    const token = findUser.generateToken();
    await new Token({ token: token }).save();

    return token;
    }

    async logout(token: string): Promise<void> {
    await Token.findOneAndUpdate({ token }, { blacklisted: true });
    }

    async forgotPassword(email: string, resetUrl: string): Promise<string | boolean> {
        const findUser = await User.findOne({email});
        if(!findUser) {
            return "User not found";
        }

        const token = await findUser.generateToken();
                
        const message = `Please click on the following link to reset your password: ${resetUrl}/${token}`;
        try{
            await sendEmail({
                email: findUser.email,
                subject: 'Password change request received',
                message: message
            });
            return "Email sent successfully";

        }catch(err ) {
            Token.findOneAndDelete({ token });
            return `Email could not be sent - ${err}`;
        }
        
    }

    async resetPassword(token: string|any ,password: string,passwordConfirm: string): Promise<string | boolean|void> {

        const jwtSecret = process.env.JWT_SECRET;
    if (!jwtSecret) {
        return "JWT secret is not defined";
    }

    let decoded: any;
    try {
        decoded = jwt.verify(token, jwtSecret);
    } catch (error) {
        return "Invalid token"; 
    }

        const tokenRecord = await Token.findOne({ token, expiresAt: { $gt: Date.now() }});  
        if (!tokenRecord) {
            return "Invalid token"; 
        } 
                
        const findUser = await User.findById(decoded.id);
        if (!findUser) {
            return "There is no user with this token";
        }
        
        findUser.password = await bcrypt.hash(password, 10);
        await findUser.save();

        await Token.deleteOne({token});
        const updateUser = await User.findByIdAndUpdate({_id: findUser._id}, {passwordChangedAt: Date.now()});
        if (!updateUser) {
            return "Password could not be reset";
        }
        await updateUser.save();
        
        //Login user after reset password automatically
        const loginToken = await updateUser.generateToken();
        if(loginToken){
            return  "Password reset successfully";
        }
        return "Password reset, but unable to log in automatically"; 
    };


    async verifyGoogleIdToken(idToken: string|any): Promise<string|undefined > {
        const oauthClient = new OAuth2Client();
    
        idToken = await this.createNewUser({email: "default_email", username: "default_username", password: "default_password"});
        if (!idToken) {
            return "Unable to create user";
        }
        console.log("idToken:", idToken);
        try {
            const response = await oauthClient.verifyIdToken({
                idToken,
                audience: [
                    process.env.GOOGLE_CLIENT_ID as string,
                ],
            });
            const payload = response.getPayload();
    
            if (payload) {
                const { email, name } = payload;
                
                if (email && name) {
                    const defaultPassword = 'default_password';
                    await this.createNewUser({ email, username: name, password: defaultPassword });
                    return "Logged in successfully";
                } else {
                    return "Email or name is missing from payload";
                }
            } else {
                return "Token is invalid";
            }
        } catch (e) {
            console.error('Error verifying token:', e);
            return 'Error occurred while verifying token';
        }
    }


    
}