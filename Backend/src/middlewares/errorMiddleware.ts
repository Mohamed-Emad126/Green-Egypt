import { Request, Response, NextFunction } from "express";
import { ICustomError } from "../interfaces/iError";
import ApiError from "../utils/apiError";


const sendErrorDev = (err : ICustomError, res : Response) : void => {
    res.status(err.statusCode!).json({
        error: err,
        message: err.message,
        stack: err.stack
    });
}

const sendErrorProd = (err : ICustomError, res : Response) : void => {
    res.status(err.statusCode!).json({
        status: err.status,
        message: err.message,
    });
}

export const globalErrorMiddleware = (err : ICustomError, req : Request , res : Response, next : NextFunction) : void => {
    err.statusCode = err.statusCode || 500;
    err.status = err.status || "error";

    if (process.env.NODE_ENV === "development") {
        sendErrorDev(err, res);

    } else if (process.env.NODE_ENV === "production") {
        
        if (err.name === "JsonWebTokenError") {
            err = new ApiError("Invalid token, please login again", 401);
        } else if (err.name === "TokenExpiredError") {
            err = new ApiError("Expired token, please login again", 401);
        }

        sendErrorProd(err, res);
    }
}

export const notFoundErrorMiddleware = (req : Request, res : Response, next : NextFunction) : void => {
    const errorMessage = req.originalUrl.startsWith('/api')
        ? `Route ${req.originalUrl} not found`
        : `The route (${req.originalUrl}) you are looking for does not exist`;

    return next(new ApiError(errorMessage, 404));
}