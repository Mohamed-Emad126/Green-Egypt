import { Request, Response, NextFunction } from "express";
import AuthService from "../services/authService";
import { IAuthInput } from "../interfaces/iUser";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";

export default class AuthController {
    
    constructor(private authService: AuthService) {
        this.createNewUser = this.createNewUser.bind(this);
        this.login = this.login.bind(this);
    }

    /**
     * @desc      Register new user
     * @route     post /api/auth/register
     * @access    Public
    */
    createNewUser = asyncHandler(async (req: Request, res: Response) => {
        const { username, email, password }: IAuthInput = req.body;
        const token = await this.authService.createNewUser({ username, email, password });
        res.status(201)
            .header("x-auth-token", token as string)
            .json({ message: 'User created successfully'});
    });

    /**
     * @desc      Login user
     * @route     post /api/auth/login
     * @access    Public
    */
    login = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { email, password }: IAuthInput = req.body;
        const loginResult = await this.authService.login({ email, password });

        if (!loginResult) {
            next(new ApiError('Wrong email or password', 400));
        }else {
            res.header("x-auth-token", loginResult as string)
                .json({ message: "Login successfully"});
        }
        
    });

    /**
     * @desc      Logout user
     * @route     POST /api/auth/logout
     * @access    Private
    */
    logout = asyncHandler(async (req: Request, res: Response) => {
        const token = req.headers.authorization!.split(" ")[1];
        if (token) {
            await this.authService.logout(token);
        }
        res.json({ message: "Logged out successfully" });
    });
}
