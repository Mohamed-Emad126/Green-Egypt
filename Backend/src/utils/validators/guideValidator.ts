import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';



export const getArticleValidator = [
    check('id').isMongoId().withMessage('Invalid article ID Format'),
    validatorMiddleware
];

export const createArticleValidator = [
    check('articleTitle').notEmpty().withMessage('Article Title is required'),

    check('content').notEmpty().withMessage('content is required'),

        validatorMiddleware
];

export const updateArticleValidator = [
    check('id').isMongoId().withMessage('Invalid Article ID Format'),

    validatorMiddleware
];

export const deleteArticleValidator= [
    check('id').isMongoId().withMessage('Invalid Article ID Format'),

    validatorMiddleware
];

export const uploadArticlePictureValidator = [
    check('id').isMongoId().withMessage('Invalid Article ID Format'),

    check('image').notEmpty().withMessage('Image is required'),
    
    validatorMiddleware
];


