import { IUser, IUserInput } from "../interfaces/iUser";
import User from "../models/userModel";

export default class UsersService {
    async getUsers() {
        return await User.find();
    }

}