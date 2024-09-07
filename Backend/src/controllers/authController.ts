import { Request, Response } from "express";
import AuthService from "../services/authService";
import { IUser } from "../interfaces/interface";

export default class AuthController {

    constructor(private authService: AuthService) {
        this.createNewUser = this.createNewUser.bind(this);
        this.login = this.login.bind(this);
    }

    async createNewUser(req: Request, res: Response) {
        try {
            const { email, password }: IUser = req.body;
            await this.authService.createNewUser({ email, password })? res.status(201).send('User created successfully') : res.status(400).send('User already exists');
        } catch (err) {
            res.status(500).send({ message: (err as Error).message });
        }
    }

    async login(req: Request, res: Response) {
        try {
            const { email, password }:IUser = req.body;
            switch (await this.authService.login({ email, password })) {
                case false:
                    res.status(400).send('Wrong email or password');
                    break;
                case null:
                    res.status(400).send('Wrong password');
                    break;
                default:
                    res.status(200).header("x-auth-token", await this.authService.login({ email, password }) as string ).send("login successfully");
            }

        } catch (err) {
            res.status(500).send({ message: (err as Error).message });
        }
    }
}
