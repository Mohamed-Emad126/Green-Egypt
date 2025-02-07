import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';



export const getNurseryValidator = [
    check('id').isMongoId().withMessage('Invalid Nursery ID Format'),
    validatorMiddleware
];

export const createNurseryValidator = [
    check('nurseryname').notEmpty().withMessage('Nursery Name is required'),

    check('location').notEmpty().withMessage('location is required'),

        validatorMiddleware
];

export const updateNurseryValidator = [
    check('id').isMongoId().withMessage('Invalid Nursery ID Format'),

    validatorMiddleware
];

export const deleteNurseryValidator= [
    check('id').isMongoId().withMessage('Invalid Nursery ID Format'),

    validatorMiddleware
];

export const uploadNurseryPictureValidator = [
    check('id').isMongoId().withMessage('Invalid Nursery ID Format'),

    check('image').notEmpty().withMessage('Image is required'),
    
    validatorMiddleware
];


