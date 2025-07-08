import UserService from "../services/userService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import sendEmail from "../utils/email";

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
        //this.claimPendingCoupons = this.claimPendingCoupons.bind(this);
        this.promoteUserToAdmin = this.promoteUserToAdmin.bind(this);
        this.getUserTrees = this.getUserTrees.bind(this);
        this.getUserPointsHistory = this.getUserPointsHistory.bind(this);
        this.getUserSavedReports = this.getUserSavedReports.bind(this);
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
        const userAfterUpdate = await this.userService.updateUser(req.params.id, req.body);

        if (userAfterUpdate.verificationToken) {
            const verifyUrl = `${req.protocol}://${req.get('host')}/api/auth/verify-email/${userAfterUpdate.verificationToken}`;
                    const message = `Please verify your email by clicking the following link within 24 hours: ${verifyUrl}`;
            
                    try {
                        await sendEmail({
                            email: userAfterUpdate.email,
                            subject: 'Verify your email',
                            message,
                        });
                    } catch (err: any) {
                        console.error(`Email could not be sent: ${err.message}`);
                    }
        }

        if (userAfterUpdate.status === 200) {
            res.json({ message: userAfterUpdate.message });
        } else {
            return next(new ApiError(userAfterUpdate.message, userAfterUpdate.status));
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
        const role = req.body.user.role;
        const id = req.body.user.id;
        const deletedUser = await this.userService.deleteUser(req.params.id, {role, id});
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
    // claimPendingCoupons = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
    //     const result = await this.userService.claimPendingCoupons(req.params.id);
    //     if (!result) {
    //         return next(new ApiError("User not found", 404));
    //     } else {
    //         res.status(result.status).json({"message": result.message, "coupon": result.coupon});
    //     }
    // });

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

   /**
     * @desc      get points history of a user
     * @route     GET /api/users/:id/points-history
     * @access    Private
    */
    getUserPointsHistory = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const pointsHistory = await this.userService.getUserPointsHistory(req.params.id);
        if (pointsHistory === false) {
            return next(new ApiError("User not found", 404));
        }

        if (pointsHistory.length === 0) {
            res.json({ message: "You have no points yet, Plant a tree , report a problem, care for a tree or locate a tree to earn points"});
        } else {
            res.json(pointsHistory);
        }
    });

    /**
     * @desc      get saved reports of a user
     * @route     GET /api/users/:id/saved-reports
     * @access    Private
    */
    getUserSavedReports = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const savedReports = await this.userService.getUserSavedReports(req.params.id);
        if (savedReports === false) {
            return next(new ApiError("User not found", 404));
        }

        if (savedReports.length === 0) {
            res.json({ message: "User has no saved reports"});
        } else {
            res.json(savedReports);
        }
    });
  
    /**
   * @desc      Save or update device token for a user
   * @route     PATCH /api/users/:id/device-token
   * @access    Private
   */
    saveDeviceToken = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
    const userId = req.params.id;
    const { deviceToken } = req.body;

    if (!deviceToken) {
    return next(new ApiError("Device token is required", 400));
    }

    const user = await this.userService.updateUser(userId, { deviceToken });

    if (!user) {
    return next(new ApiError("User not found", 404));
    }

    res.status(200).json({ message: "Device token updated", user });
      
    });
}