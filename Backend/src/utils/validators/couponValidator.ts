import { check } from "express-validator";
import  { validatorMiddleware } from '../../middlewares/validatorMiddleware';


export const getCouponValidator = [
    check('id').isMongoId().withMessage('Invalid coupon ID Format'),
    validatorMiddleware
]

export const redeemCouponCodeValidator = [
    check('id').isMongoId().withMessage('Invalid coupon ID Format'),
    validatorMiddleware
]


export const createCouponValidator = [
    check('codes')
        .isArray({ min: 1 }).withMessage('Codes array must contain at least one code')
        .custom((codes) => {
            const uniqueCodes = [...new Set(codes)];
            return uniqueCodes.length === codes.length;
        })
        .withMessage('Codes must be unique'),

    check('codes.*')
        .trim()
        .isLength({ min: 9, max: 9 }).withMessage('Each code must be exactly 9 characters')
        .isAlphanumeric().withMessage('The code must contain only letters and numbers.'),
    
    check('value')
        .notEmpty().withMessage('Value is required')
        .isFloat({ min: 0.01  }).withMessage('Value must be a positive number'),

    check('cost')
        .notEmpty().withMessage('Cost is required')
        .isFloat({ min: 50 }).withMessage('Cost must be a positive number greater than 50'),
    
    check('brand')
        .notEmpty().withMessage('Brand is required')
        .isMongoId().withMessage('Invalid brand ID'),
    
    check('expiryDate')
        .notEmpty().withMessage('Expiry date is required')
        .isISO8601().withMessage('Expiry date must be a valid ISO8601 date')   
        .isAfter(new Date().toISOString()).withMessage('Expiry date must be in the future'), 

    validatorMiddleware
];

export const updateCouponValidator = [

    check('codes')
        .optional()
        .isArray({ min: 1 }).withMessage('Codes array must contain at least one code')
        .custom((codes) => {
            const uniqueCodes = [...new Set(codes)];
            return uniqueCodes.length === codes.length;
        })
        .withMessage('Codes must be unique'),

    check('codes.*')
        .if((value, { req }) => req.body.codes !== undefined) 
        .trim()
        .isLength({ min: 9, max: 9 }).withMessage('Each code must be exactly 9 characters')
        .isAlphanumeric().withMessage('The code must contain only letters and numbers.'),
    
    check('value')
        .optional()
        .isFloat({ min: 0.1 }).withMessage('Value must be a positive number'),

    check('cost')
        .optional()
        .isFloat({ min: 50 }).withMessage('Cost must be a positive number greater than 50'),
    
    check('brand')
        .optional()
        .isMongoId().withMessage('Invalid brand ID'),
    
    check('expiryDate')
        .optional()
        .isISO8601().withMessage('Expiry date must be a valid ISO8601 date (YYYY-MM-DD)')   
        .isAfter(new Date().toISOString()).withMessage('Expiry date must be in the future'), 

    validatorMiddleware
];

export const deleteCouponValidator = [
    check('id').isMongoId().withMessage('Invalid coupon ID Format'),
    validatorMiddleware
]