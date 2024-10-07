import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import ApiError from "../utils/apiError";
import User from "../models/userModel";
import Token from "../models/tokenModel";
import asyncHandler from 'express-async-handler';

export const verifyToken = asyncHandler( async (req : Request, res : Response, next : NextFunction) => {
    let token : string | undefined;
    if(req.headers.authorization && req.headers.authorization.startsWith("Bearer")) {
        token = req.headers.authorization!.split(" ")[1];

        const blacklistedToken = await Token.findOne({ token, blacklisted: true });
        if (blacklistedToken) {
            return next(new ApiError("you are not logged in, please login to access this route", 401));
        }

        const decoded : any = jwt.verify(token, process.env.JWT_SECRET! as string);

        const user = await User.findById(decoded.id);
        if(!user) {
            return next(new ApiError("The user belonging to this token does not exist", 401));
        }

        if (user.passwordChangedAt instanceof Date) {
            const passChangedTimestamp = Math.floor(user.passwordChangedAt.getTime() / 1000);
            if (passChangedTimestamp > decoded.iat) {
                return next(new ApiError('User recently changed his password. please login again..',401));
            }
        }

        req.body.user = { ...decoded, id: user.id };
        next();
    } else {
        return next(new ApiError("you are not logged in, please login to access this route", 401));
    }
});

export const verifyTokenAndAuthorizationMiddleware = (req : Request, res : Response, next : NextFunction) : void => {
    verifyToken(req, res, (err) => {
        if(err) {
            return next(err);
        }
        
        if(req.body.user.id === req.params.id) {
            next();
        } else {
            return next(new ApiError("You are not authorized", 403));
        }
    });
}

