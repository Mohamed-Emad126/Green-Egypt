import { check } from "express-validator";
import  { validatorMiddleware } from '../../middlewares/validatorMiddleware';


export const getCommentByIdValidator = [
    check('id').isMongoId().withMessage('Invalid Comment ID Format'),
    validatorMiddleware
]

export const getCommentsByReportValidator = [
    check('id').isMongoId().withMessage('Invalid Report ID Format'),
    validatorMiddleware
]

export const createCommentValidator = [
    check('id').isMongoId().withMessage('Invalid Report ID Format'),

    check('content').notEmpty().withMessage('Comment is required'),

    validatorMiddleware
];

export const updateCommentValidator = [
    check('id').isMongoId().withMessage('Invalid Comment ID Format'),

    check('content').notEmpty().withMessage('Comment is required'),

    validatorMiddleware
];

export const deleteCommentValidator = [
    check('id').isMongoId().withMessage('Invalid Comment ID Format'),
    validatorMiddleware
]

export const getCommentRepliesValidator = [
    check('id').isMongoId().withMessage('Invalid Comment ID Format'),
    validatorMiddleware
]