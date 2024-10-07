import { Request } from 'express';
import multer from 'multer';
import path from 'path';


const fileFilter = (req: Request, file: Express.Multer.File, cb: multer.FileFilterCallback) => {
    if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/jpg' || file.mimetype === 'image/png') {
        cb(null, true);
    } else {
        cb(new multer.MulterError('LIMIT_UNEXPECTED_FILE', file.fieldname));
    }
};

const userStorage = multer.diskStorage({
    destination: (req: Request, file, cb) => {
        cb(null, path.join(__dirname, '../uploads/userImages')); 
    },
    filename: (req: Request, file, cb) => {
        const uniqueSuffix = `${Date.now()}-${file.originalname}`;
        cb(null, uniqueSuffix); 
    }
});

const uploadUserImage = multer({
    storage: userStorage,
    fileFilter: fileFilter,
    limits: { fileSize: 1024 * 1024 * 5 }
}).single('profilePic');


const treeStorage = multer.diskStorage({
    destination: (req: Request, file, cb) => {
        cb(null, path.join(__dirname, '../uploads/treeImages'));
    },
    filename: (req: Request, file, cb) => {
        const uniqueSuffix = `${Date.now()}-${file.originalname}`;
        cb(null, uniqueSuffix); 
    }
});

const uploadTreeImage = multer({
    storage: treeStorage,
    fileFilter: fileFilter,
    limits: { fileSize: 1024 * 1024 * 5 } 
}).single('image');

export { uploadUserImage, uploadTreeImage };
