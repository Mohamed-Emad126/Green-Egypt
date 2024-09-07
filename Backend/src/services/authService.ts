import { IUser } from "../interfaces/interface";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

//* Service Layer => Data Storage and Retrieval
export default class AuthService {

    constructor(private users : IUser[]) {
        this.users = users;
    }

    getUsers() {
        return this.users;
    }

    async createNewUser(newUser : IUser) {
        const findUser = this.users.find(user => newUser.email === user.email);
        if(findUser) {
            return false;
        } else {
            this.users.push({id: this.users.length+1, email: newUser.email, password: await bcrypt.hash(newUser.password, 10) });
            return true;
        }
    }

    async login(userData : IUser) {
        const findUser = this.users.find(user => userData.email === user.email );
        if(!findUser) {
            return false;
        } else {
            const isPasswordMatch = await bcrypt.compare(userData.password, findUser.password);
            if(isPasswordMatch) {
                const token = jwt.sign({id : findUser.id}, 'privatekey');
                return token;
            }else{
                return null;
            } 
        } 
    }
}

