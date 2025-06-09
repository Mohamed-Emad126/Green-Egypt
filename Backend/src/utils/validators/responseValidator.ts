import { check } from "express-validator";
import  { validatorMiddleware } from '../../middlewares/validatorMiddleware';


export const getResponseByIdValidator = [
    check('id').isMongoId().withMessage('Invalid Response ID Format'),
    validatorMiddleware
]

export const getReportResponsesValidator = [
    check('id').isMongoId().withMessage('Invalid Report ID Format'),
    validatorMiddleware
]

export const createResponseValidator = [
    check('id').isMongoId().withMessage('Invalid Report ID Format'),

    check('images').custom((_, { req }) => {
        if (!req.files || req.files.length === 0) {
            throw new Error("at least one image is required");
        }
        return true;
    }),

    validatorMiddleware
];

export const deleteResponseValidator = [
    check('id').isMongoId().withMessage('Invalid Response ID Format'),
    validatorMiddleware
];

export const voteResponseValidator = [
    check('id').isMongoId().withMessage('Invalid Response ID Format'),

    check('vote')
        .notEmpty().withMessage('Vote Is Required')
        .isBoolean().withMessage('Invalid Vote, please Enter true for positive vote or false for negative vote')
];

export const addResponseImagesValidator = [
    check('id').isMongoId().withMessage('Invalid Response ID Format'),

    check('images').custom((_, { req }) => {
        if (!req.files || req.files.length === 0) {
            throw new Error("at least one image is required");
        }
        return true;
    }),

    validatorMiddleware
];

export const deleteResponseImageValidator = [
    check('id').isMongoId().withMessage('Invalid Response ID Format'),

    check('imageURL')
        .notEmpty().withMessage('Image URL is required')
        .isURL().withMessage('Invalid URL format')
        .matches(/^https:\/\/res\.cloudinary\.com\/.+/)
        .withMessage('Only Cloudinary URLs are allowed'),

    validatorMiddleware
];

export const analysisResponseValidator = [
    check('id').isMongoId().withMessage('Invalid Response ID Format'),
    validatorMiddleware
];

export const verifyResponseValidator = [
    check('id').isMongoId().withMessage('Invalid Response ID Format'),
    validatorMiddleware
];
