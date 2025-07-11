import { IAuthInput } from "../interfaces/iUser";
import User from "../models/userModel";
import Token from "../models/tokenModel";
import bcrypt from "bcryptjs";
import  sendEmail from "../utils/email";
import jwt from "jsonwebtoken";
import { OAuth2Client } from "google-auth-library";


export default class AuthService {

    async createNewUser(newUser : IAuthInput): Promise<{ token: string; user_id: string, verificationToken: string }> {
        const user = new User({
            username: newUser.username, 
            email: newUser.email, 
            password: await bcrypt.hash(newUser.password, 10),
            isVerified: false,
        });
        await user.save();

        const verificationToken = await user.generateToken(process.env.VERIFICATION_TOKEN_EXPIRE_TIME);

        const token = await user.generateToken();
        return { token, user_id: user.id, verificationToken };

    }

    async verifyEmail(token: string): Promise<{ status: number; message: string }> {
        const tokenRecord = await Token.findOne({ token });
        if (!tokenRecord) {
            return { status: 400, message: "Invalid token" };
        }

        const user = await User.findById(tokenRecord.user);
        if (!user) {
            return { status: 400, message: "User not found" };
        };

        user.isVerified = true;
        await user.save();

        await Token.deleteOne({ token });

        return { status: 200, message: "Email verified successfully" };
    }

    async login(userData : IAuthInput) {
        const findUser = await User.findOne({email: userData.email});
        if(!findUser) {
            return { status: 400, message: "Wrong email" };
        } else if( !await bcrypt.compare(userData.password, findUser.password)){
            return { status: 400, message: "Wrong password" };
        }
        
        const token = await findUser.generateToken();
        return { status: 200, token, user_id : findUser.id};
    }

    async logout(token: string): Promise<void> {
        await Token.findOneAndUpdate({ token }, { blacklisted: true });
    }

    async forgotPassword(email: string, resetUrl: string): Promise<string | boolean> {
        const findUser = await User.findOne({email});
        if(!findUser) {
            return "User not found";
        }
        const token = await findUser.generateToken(process.env.RESET_TOKEN_EXPIRE_TIME);
                
        const message = `Please click on the following link to reset your password: ${resetUrl}/${token}`;
        try{
            await sendEmail({
                email: findUser.email,
                subject: 'Password change request received',
                message: message
            });
            return "Email sent successfully";
        }catch(err) {
            Token.findOneAndDelete({ token });
            return `Email could not be sent - ${err}`;
        }
        
    }

    async resetPassword(token: string | any, password: string): Promise<string | boolean | void> {

        let decoded: any;
        try {
            decoded = jwt.verify(token, process.env.JWT_SECRET as string);
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

    async verifyGoogleIdToken(idToken: string) : Promise<string> {
        const oauthClient = new OAuth2Client();

        if (!idToken) {
        return "ID Token is missing";
        }
        try {
            const response = await oauthClient.verifyIdToken({
                idToken,
                audience: [process.env.GOOGLE_CLIENT_ID as string],
        });
        
        const payload = response.getPayload();

            if (payload) {
                const { email, name } = payload;

                if (email && name) {
                    const defaultPassword = 'default_password';

                    const existingUser = await User.findOne({email});
                    if (!existingUser) {
                    await this.createNewUser({
                        email,
                        username: name,
                        password: defaultPassword,
                    });
                    }

                    return "Logged in successfully";
                } else {
                    return "Email or name is missing from payload";
                }
            } else {
                return "Invalid token";
            }
        } catch (e) {
            console.error('Error verifying token:', e);
            return 'Error occurred while verifying token';
        }
    }
}
