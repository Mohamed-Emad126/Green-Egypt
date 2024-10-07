import { IAuthInput } from "../interfaces/iUser";
import User from "../models/userModel";
import Token from "../models/tokenModel";
import bcrypt from "bcryptjs";

// TODO: section authentication and authorization

export default class AuthService {

    async createNewUser(newUser : IAuthInput) : Promise<string | boolean> {
        const user = new User({username: newUser.username, 
                                email: newUser.email, 
                                password: await bcrypt.hash(newUser.password, 10)});
        await user.save();

        const token = user.generateToken();
        await new Token({ token: token }).save();

        return token;
        
    }

    async login(userData : IAuthInput): Promise<string | boolean> {
        const findUser = await User.findOne({email: userData.email});
        if(!findUser || !(await bcrypt.compare(userData.password, findUser.password))) {
            return false;
        } 
        
        const token = findUser.generateToken();
        await new Token({ token: token }).save();

        return token;
    }

    async logout(token: string): Promise<void> {
        await Token.findOneAndUpdate({ token }, { blacklisted: true });
    }
}

