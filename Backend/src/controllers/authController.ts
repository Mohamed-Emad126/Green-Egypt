import { Request, Response, NextFunction } from "express";
import AuthService from "../services/authService";
import { IAuthInput } from "../interfaces/iUser";
import asyncHandler from "express-async-handler";
import ApiError from "../utils/apiError";
import  sendEmail from "../utils/email";


export default class AuthController {
    constructor(private authService: AuthService) {
        this.createNewUser = this.createNewUser.bind(this);
        this.login = this.login.bind(this);
        this.logout = this.logout.bind(this);
        this.forgotPassword = this.forgotPassword.bind(this);
        this.resetPassword = this.resetPassword.bind(this);
        this.verifyGoogleIdToken = this.verifyGoogleIdToken.bind(this);
        this.verifyEmail = this.verifyEmail.bind(this);
    }


    /**
     * @desc      Register new user
     * @route     post /api/auth/register
     * @access    Public
    */
    createNewUser = asyncHandler(async (req: Request, res: Response) => {
        const { username, email, password }: IAuthInput = req.body;
        const result = await this.authService.createNewUser({ username, email, password });

        const verifyUrl = `${req.protocol}://${req.get('host')}/api/auth/verify-email/${result.verificationToken}`;
        const message = `Please verify your email by clicking the following link within 24 hours: ${verifyUrl}`;

        try {
            await sendEmail({
                email,
                subject: 'Verify your email',
                message,
            });
        } catch (err: any) {
            console.error(`Email could not be sent: ${err.message}`);
        }

        res.status(201)
            .header('x-auth-token', result.token)
            .json({
                message: 'User created successfully. A verification email has been sent.',
                user_id: result.user_id,
            });
    });

    /**
     * @desc      Verify email of user
     * @route     post /api/auth/verify-email/:token
     * @access    Public
    */
    verifyEmail = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        try {
            const { token } = req.params;
            const result = await this.authService.verifyEmail(token);
            res.json(result);
        } catch (error) {
            return next(new ApiError("Email verification failed", 400));
        }
    });

    /**
     * @desc      Login user
     * @route     post /api/auth/login
     * @access    Public
    */
    login = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { email, password }: IAuthInput = req.body;
        const loginResult = await this.authService.login({ email, password });
        if (loginResult.status === 400) {
            next(new ApiError(loginResult.message!, 400));
        } else {
            res.header("x-auth-token", loginResult.token)
            .json({ 
                message: "Login successfully",
                user_id: loginResult.user_id
            });
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

    /**
     * @desc      Send reset link
     * @route     post /api/auth/forgotPassword
     * @access    Public
    */
    forgotPassword= asyncHandler(async (req: Request, res: Response,next: NextFunction) => {
        // get user by email
        const { email } = req.body;
        const resetUrl = `${req.protocol}://${req.get('host')}/api/auth/reset-password`;
        const message = await this.authService.forgotPassword(email, resetUrl);
        
        switch (message) {
            case 'User not found':
                next(new ApiError("There is no user with this email", 404));
                break;
            case 'Email sent successfully':
                res.json({message});
                break;
            default:
                next(new ApiError(message as string, 400));
        }
    });

    /**
     * @desc      Reset password
     * @route     post /api/auth/reset-password/:token
     * @access    Private
    */
    resetPassword = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { password } = req.body;
    
        const token = req.params.token;
        if (!token) {
            return next(new ApiError("Token is missing", 400));
        }
        
        const message = await this.authService.resetPassword(token, password);

        switch (message) {
            case 'Invalid token':
                next(new ApiError("Invalid token", 404));
                break;
            case 'There is no user with this token':
                next(new ApiError("There is no user with this token", 404));
                break;
            case 'Password could not be reset':
                next(new ApiError("Password could not be reset", 400));
                break;
            case 'Password reset successfully':
                res.json({message});
                break;
            default:
                next(new ApiError(message as string, 400));
        }
    });

    /**
     * @desc      Verify google id token
     * @route     post /api/auth/google/callback
     * @access    Public
    */
    verifyGoogleIdToken = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { idToken } = req.body;
        if (!idToken) {
            next( res.status(400).json({ error: 'ID Token is missing' }));
        }

        const message = await this.authService.verifyGoogleIdToken(idToken);
        switch (message) {
            case 'Invalid token':
                next(new ApiError('Invalid token', 400));
                break;
            case 'Email or name is missing from payload':
                next(new ApiError('Email or name is missing from payload', 400));
                break;
            case 'Logged in successfully':
                res.json({message});
                break;
            case 'Error occurred while verifying token':
                next(new ApiError('Error occurred while verifying token', 400));
                break;
            case "Unable to create user":
                next(new ApiError("Unable to create user", 400));
                break;
            default:
                next(new ApiError(message as string, 400));
        }
    });
}
