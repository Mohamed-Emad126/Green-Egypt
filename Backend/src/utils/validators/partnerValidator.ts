import { check } from 'express-validator';
import  { validatorMiddleware } from '../../middlewares/validatorMiddleware';
import Partner from '../../models/partnerModel';

export const getPartnerValidator = [
    check('id').isMongoId().withMessage('Invalid partner ID Format'),
    validatorMiddleware
]

export const createNewPartnerValidator = [
    check('partnerName')
        .notEmpty().withMessage('Partner name is required')
        .isLength({min : 3}).withMessage('Partner name must be at least 3 characters long')
        .isLength({max : 35}).withMessage('Partner name must be at most 35 characters long')
        .custom(async (partnerName) => {
            const partner = await Partner.findOne({partnerName});
            if (partner) {
                throw new Error('This partner already exists');
            }
            return true;
        }),

    check('startDate')
        .notEmpty().withMessage('Start date is required')
        .isISO8601().withMessage('Start date must be a valid date in ISO8601 format')
        .isAfter(new Date().toISOString()).withMessage('Start date must be in the future'),

    check('duration')
        .notEmpty().withMessage('Duration is required')
        .isInt({ min: 1 }).withMessage('Duration must be a positive number'),

    check('durationUnit')
        .notEmpty().withMessage('Duration unit is required')
        .isIn(['days', 'months', 'years', 'one-time']).withMessage('Invalid duration unit'),

    check('website')
        .optional()
        .trim()
        .isURL().withMessage('Invalid website URL'),

    check('description')
        .notEmpty().withMessage('Description is required')
        .isLength({max : 700}).withMessage('Description must be at most 700 characters long'),

    check('image').custom((_, { req }) => {
        if (!req.file) {
            throw new Error("Image is required");
        }
        return true;
    }),
    
    validatorMiddleware
]

export const updatePartnerValidator = [
    check('partnerName')
        .optional()
        .isLength({min : 3}).withMessage('Partner name must be at least 3 characters long')
        .isLength({max : 35}).withMessage('Partner name must be at most 35 characters long')
        .custom(async (partnerName) => {
            const partner = await Partner.findOne({partnerName});
            if (partner) {
                throw new Error('This partner already exists');
            }
            return true;
        }),

    check('startDate')
        .optional()
        .isDate().withMessage('Start date must be a valid date'),

    check('duration')
        .optional()
        .isNumeric().withMessage('Duration must be a number'),

    check('durationUnit')
        .optional()
        .isIn(['days', 'months', 'years', 'one-time']).withMessage('Invalid duration unit'),

    check('website')
        .optional()
        .isURL().withMessage('Invalid website URL'),

    check('description')
        .optional()
        .isLength({max : 700}).withMessage('Description must be at most 700 characters long'),
    
    validatorMiddleware
]

export const deletePartnerValidator = [
    check('id').isMongoId().withMessage('Invalid partner ID Format'),
    validatorMiddleware
]

export const uploadPartnerLogoValidator = [
    check('id').isMongoId().withMessage('Invalid partner ID Format'),

    check('image').custom((_, { req }) => {
        if (!req.file) {
            throw new Error("Image is required");
        }
        return true;
    }),

    validatorMiddleware
]
