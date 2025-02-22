import { Request, Response, NextFunction } from 'express';
import multer from 'multer';
import path from 'path';
import ApiError from '../utils/apiError';

const storage = multer.diskStorage({
    destination: (req: Request, file, cb) => {
        cb(null, path.join(__dirname, '../uploads')); 
    },
    filename: (req: Request, file, cb) => {
        const uniqueSuffix = `${Date.now()}-${file.originalname}`;
        cb(null, uniqueSuffix); 
    }
});

const fileFilter = (req: Request, file: Express.Multer.File, cb: multer.FileFilterCallback) => {
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/jpg' || file.mimetype === 'image/png') {
        cb(null, true);
    } else {
        cb(new multer.MulterError('LIMIT_UNEXPECTED_FILE', file.fieldname));
    }
};

export const uploadImage = (req: Request, res: Response, next: NextFunction) => {
    const user = req.body.user;
    multer({
        storage: storage,
        fileFilter: fileFilter,
        limits: { fileSize: 1024 * 1024 * 5 }
    }).single('image') (req, res, (err) => {
        if (err) {
            if (err instanceof multer.MulterError) {
                next(new ApiError(err.message, 400));
            } else {
                next(new ApiError('Something went wrong while uploading the image.', 500));
            }
        } else {
            req.body.user = user;
            next();
        }
    });
};

export const uploadImages = (req: Request, res: Response, next: NextFunction) => {
    const user = req.body.user;
    multer({
        storage: storage,
        fileFilter: fileFilter,
        limits: { fileSize: 1024 * 1024 * 5 }
    }).array('images') (req, res, (err) => {
        if (err) {
            if (err instanceof multer.MulterError) {
                next(new ApiError(err.message, 400));
            } else {
                next(new ApiError('Something went wrong while uploading the image.', 500));
            }
        } else {
            req.body.user = user;
            next();
        }
    });
}
