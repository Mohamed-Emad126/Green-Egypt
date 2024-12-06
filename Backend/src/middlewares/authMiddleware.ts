import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import ApiError from "../utils/apiError";
import User from "../models/userModel";
import Token from "../models/tokenModel";
import Report from "../models/reportModel";
import asyncHandler from 'express-async-handler';

export const verifyToken = asyncHandler( async (req : Request, res : Response, next : NextFunction) => {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
        return next(new ApiError("Unauthorized access - please log in", 401));
    }

    const token = authHeader.split(" ")[1];
    const blacklistedToken = await Token.findOne({ token, blacklisted: true });
    if (blacklistedToken) {
        return next(new ApiError("Session expired - Please log in again", 401));
    }

    const decoded : any = jwt.verify(token, process.env.JWT_SECRET! as string);
    const user = await User.findById(decoded.id);
    if(!user) {
        return next(new ApiError("No user found for this token", 401));
    }

    if (user.passwordChangedAt instanceof Date) {
        const passChangedTimestamp = Math.floor(user.passwordChangedAt.getTime() / 1000);
        if (passChangedTimestamp > decoded.iat) {
            return next(new ApiError("Password recently changed. Please log in again",401));
        }
    }

    req.body.user = { id: user.id, role: user.role };
    next();
});

export const verifyUserMiddleware = (req : Request, res : Response, next : NextFunction) : void => {
    verifyToken(req, res, (err) => {
        if(err) {
            return next(err);
        }
        
        if(req.body.user.id === req.params.id || req.body.user.role === 'admin') {
            next();
        } else {
            return next(new ApiError("You are not authorized to perform this action", 403));
        }
    });
}

export const verifyAdminMiddleware = (req: Request, res: Response, next: NextFunction): void => {
    verifyToken(req, res, (err) => {
        if(err) {
            return next(err);
        }
        
        if (req.body.user.role === 'admin') {
            next();
        } else {
            return next(new ApiError("Admin privileges are required to access this route", 403));
        }
    });
};

export const verifyReporterMiddleware = asyncHandler(async (req : Request, res : Response, next : NextFunction) => {
    verifyToken(req, res, async (err) => {
        if (err) {
            return next(err);
        }

        const report = await Report.findById(req.params.id);
        if (!report) {
            return next(new ApiError("Report not found", 404));
        }

        if (req.body.user.id === report.createdBy.toString() || req.body.user.role === 'admin') {
            next();
        } else {
            return next(new ApiError("You are not authorized to perform this action", 403));
        }
    });
});


