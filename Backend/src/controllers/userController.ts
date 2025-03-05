import UserService from "../services/userService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";



export default class UserController {

    constructor(private userService: UserService) {
        this.getUsers = this.getUsers.bind(this);
        this.getUserById = this.getUserById.bind(this);
        this.updateUser = this.updateUser.bind(this);
        this.deleteUser = this.deleteUser.bind(this);
        this.changeUserPassword = this.changeUserPassword.bind(this);
        this.uploadUserPicture = this.uploadUserPicture.bind(this);
        this.deleteUserPicture = this.deleteUserPicture.bind(this);
        this.updateUserPoints = this.updateUserPoints.bind(this);
        this.claimPendingCoupons = this.claimPendingCoupons.bind(this);
        this.promoteUserToAdmin = this.promoteUserToAdmin.bind(this);
    }

    /**
     * @desc      Get all users
     * @route     GET /api/users
     * @access    Public (development mode)
    */
    getUsers = asyncHandler(async (req: Request, res: Response) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 5;
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        const users = await this.userService.getUsers(page, limit, filters);
        res.json({ length: users.length, page: page, users: users });
    });

    /**
     * @desc      Get user by id
     * @route     GET /api/users/:id
     * @access    Public
    */
    getUserById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const user = await this.userService.getUserById(req.params.id);
        if (user) {
            res.json(user);
        } else {
            return next(new ApiError("User not found", 404));
        }
    });

    /**
     * @desc      Update user
     * @route     PATCH /api/users/:id
     * @access    Private
    */
    updateUser = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        if(req.body.points) {
            return next(new ApiError("Points cannot be updated", 400));
        }
        
        const userAfterUpdate = await this.userService.updateUser(req.params.id, req.body);
        if (userAfterUpdate) {
            res.json({ message: "User updated successfully"});
        } else {
            return next(new ApiError("User not found", 404));
        }
        
    });

    /**
     * @desc      Change user password
     * @route     PUT /api/users/:id/change-password
     * @access    Private
    */
    changeUserPassword = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        await this.userService.changeUserPassword(req.params.id, req.body.newPassword);
        res.json({ message: "Password changed successfully"});
    });

    /**
     * @desc      Delete user
     * @route     DELETE /api/users/:id
     * @access    Private
    */
    deleteUser = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const deletedUser = await this.userService.deleteUser(req.params.id);
        if (deletedUser) {
            res.json({ message: "User deleted successfully"});
        } else {
            return next(new ApiError("User not found", 404));
        }
        
    });

    /**
     * @desc      Upload user picture
     * @route     PATCH /api/users/:id/image
     * @access    Private
    */
    uploadUserPicture = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        if(!req.file) {
            return next(new ApiError("No file uploaded", 400));
        }
        const result = await this.userService.uploadUserPicture(req.params.id, req.file);
        if (result) {
            res.json({ message: "Picture updated successfully"});
        } else {
            return next(new ApiError("User not found", 404));
        }
    });

    /**
     * @desc      Delete user picture
     * @route     DELETE /api/users/:id/image
     * @access    Private
    */
    deleteUserPicture = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.userService.deleteUserPicture(req.params.id);
        if (result) {
            res.json({ message: "Picture deleted successfully"});
        } else {
            return next(new ApiError("User not found", 404));
        }
    });

    /**
     * @desc      Update user points
     * @route     PUT /api/users/:id/activity
     * @access    Private
    */
    updateUserPoints = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.userService.updateUserPoints(req.params.id, req.body.activity);
        if (!result) {
            return next(new ApiError("User not found", 404));

        } else {
            res.json(result);
        }
        
    });

    /**
     * @desc      Claim pending coupons for a user
     * @route     POST /api/users/:id/claim-pending-coupons
     * @access    Private
     */
    claimPendingCoupons = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.userService.claimPendingCoupons(req.params.id);
        if (!result) {
            return next(new ApiError("User not found", 404));
        } else {
            res.status(result.status).json({"message": result.message, "coupon": result.coupon});
        }
    });

    /**
     * @desc      Promote user to admin
     * @route     PUT /api/users/promote-admin/:id
     * @access    Private(admin)
     */
    promoteUserToAdmin = asyncHandler(async (req: Request, res: Response, next: NextFunction) =>{
        const userID = req.params.id;
        
        const result = await this.userService.promoteUserToAdmin(userID);        
        if (!result) {
            return next(new ApiError("Failed to promote user to admin", 500));
        } else {
            res.json(result);
        }

    });

    /**
     * @desc      get trees that a user has planted
     * @route     GET /api/users/:id/trees
     * @access    Private
    */
    getUserTrees = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const trees = await this.userService.getUserTrees(req.params.id);
        if (trees === false) {
            return next(new ApiError("User not found", 404));
        }

        if (trees.length === 0) {
            res.json({ message: "User has no trees"});
        } else {
            res.json(trees);
        }
    });
}