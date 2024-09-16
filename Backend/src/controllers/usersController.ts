import UsersService from "../services/usersService";
import { Request, Response } from "express";


export default class UsersController {

    constructor(private usersService: UsersService) {
        this.getUsers = this.getUsers.bind(this);
    }

    async getUsers(req: Request, res: Response) {
        try {
            const users = await this.usersService.getUsers();
            res.json(users);
        } catch (err) {
            res.status(500).json({ message: "Error retrieving users" });
        }
    }
}