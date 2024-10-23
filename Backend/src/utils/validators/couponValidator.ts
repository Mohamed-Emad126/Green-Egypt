import { check } from "express-validator";
import  { validatorMiddleware } from '../../middlewares/validatorMiddleware';
import Coupon from "../../models/couponModel";


export const getCouponValidator = [
    check('id').isMongoId().withMessage('Invalid coupon ID Format'),
    validatorMiddleware
]


export const createCouponValidator = [
    check('codes').isArray({ min: 1 }).withMessage('Codes array must contain at least one code'),

    check('codes.*')
        .notEmpty().withMessage('Each code is required')
        .isLength({ min: 6, max: 6 }).withMessage('Each code must be exactly 6 characters')
        .custom(async (code) => {
            const existingCoupon = await Coupon.findOne({ code });
            if (existingCoupon) {
                throw new Error(`Coupon code ${code} already exists`);
            }
            return true;
        }),
    
    check('value')
        .notEmpty().withMessage('Value is required')
        .isFloat({ min: 1 }).withMessage('Value must be a positive number'),
    
    check('brand')
        .notEmpty().withMessage('Brand is required')
        .isMongoId().withMessage('Invalid brand ID'),
    
    check('expiryDate')
        .notEmpty().withMessage('Expiry date is required')
        .isDate().withMessage('Expiry date must be a valid date')   //isISO8601
        .isAfter(new Date().toString()).withMessage('Expiry date must be in the future'), //toISOString

    validatorMiddleware
];

export const updateCouponValidator = [


    check('code')
        .optional()
        .isLength({ min: 6, max: 6 }).withMessage('Each code must be exactly 6 characters')
        .custom(async (code) => {
            const existingCoupon = await Coupon.findOne({ code });
            if (existingCoupon) {
                throw new Error(`Coupon code ${code} already exists`);
            }
            return true;
        }),
    
    check('value')
        .optional()
        .isFloat({ min: 1 }).withMessage('Value must be a positive number'),
    
    check('brand')
        .optional()
        .isMongoId().withMessage('Invalid brand ID'),
    
    check('expiryDate')
        .optional()
        .isDate().withMessage('Expiry date must be a valid date')   //isISO8601
        .isAfter(new Date().toString()).withMessage('Expiry date must be in the future'), //toISOString

    validatorMiddleware
];

export const deleteCouponValidator = [
    check('id').isMongoId().withMessage('Invalid coupon ID Format'),
    validatorMiddleware
]