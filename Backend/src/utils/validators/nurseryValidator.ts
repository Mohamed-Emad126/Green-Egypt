import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';

export const getAllNurseriesValidator = [
    check('location')
        .optional()
        .isObject().withMessage('Location must be an object'),

    check('location.type')
        .if(check('location').exists())
        .notEmpty().withMessage('Location type is required')
        .equals('Point').withMessage('Location must be a Point'),
        
    check('location.coordinates')
        .if(check('location').exists())
        .notEmpty().withMessage('Location coordinates is required')
        .isArray().withMessage('Location must be an array')
        .custom((coords) => {
            if (!Array.isArray(coords) || coords.length !== 2) {
                throw new Error('Coordinates must have exactly two elements');
            }
            return true;
        }),
        
    check('location.coordinates.0')
        .if(check('location.coordinates').exists())
        .notEmpty().withMessage('Longitude is required')
        .isFloat({ min: 24, max: 37 }).withMessage('Longitude must be between 24 and 37'),

    check('location.coordinates.1')
        .if(check('location.coordinates').exists())
        .notEmpty().withMessage('Latitude is required')
        .isFloat({ min: 22, max: 32 }).withMessage('Latitude must be between 22 and 32'),

    validatorMiddleware
];

export const getNurseryValidator = [
    check('id').isMongoId().withMessage('Invalid Nursery ID Format'),

    validatorMiddleware
];

export const createNurseryValidator = [
    check('nurseryName').notEmpty().withMessage('Nursery Name is required'),

    check('location')
        .notEmpty().withMessage('Location is required')
        .custom((value) => {
            try {
                if (typeof value === "string") {
                    value = JSON.parse(value);
                }
                if (!value.type || value.type !== 'Point') {
                    throw new Error("Location must have type 'Point'");
                }
                if (!Array.isArray(value.coordinates) || value.coordinates.length !== 2) {
                    throw new Error("Coordinates must be an array with exactly two elements [longitude, latitude]");
                }
                if (value.coordinates[0] < 24 || value.coordinates[0] > 37) {
                    throw new Error("Longitude must be between 24 and 37");
                }
                if (value.coordinates[1] < 22 || value.coordinates[1] > 32) {
                    throw new Error("Latitude must be between 22 and 32");
                }            
                return true;
            } catch (error) {
                throw new Error("Invalid location format. Must be a valid JSON object.");
            }
        }),

        check('rate')
            .notEmpty().withMessage('Rate is required')
            .isFloat({ min: 0, max: 5 }).withMessage('Rate must be between 0 and 5'),

        check('address')
            .notEmpty().withMessage('Address is required'),

        validatorMiddleware
];

export const updateNurseryValidator = [
    check('id').isMongoId().withMessage('Invalid Nursery ID Format'),

    check('nurseryName')
        .optional()
        .isString().withMessage('Nursery Name must be a string')
        .isLength({ min: 3, max: 100 }).withMessage('Nursery Name must be at least 3 and not exceed 100 characters long'),

    check('location')
        .optional()
        .isObject().withMessage('Location must be an object'),

    check('location.type')
        .if(check('location').exists())
        .notEmpty().withMessage('Location type is required')
        .equals('Point').withMessage('Location must be a Point'),
        
    check('location.coordinates')
        .if(check('location').exists())
        .notEmpty().withMessage('Location coordinates is required')
        .isArray().withMessage('Location must be an array')
        .custom((coords) => {
            if (!Array.isArray(coords) || coords.length !== 2) {
                throw new Error('Coordinates must have exactly two elements');
            }
            return true;
        }),
        
    check('location.coordinates.0')
        .if(check('location.coordinates').exists())
        .notEmpty().withMessage('Longitude is required')
        .isFloat({ min: 24, max: 37 }).withMessage('Longitude must be between 24 and 37'),

    check('location.coordinates.1')
        .if(check('location.coordinates').exists())
        .notEmpty().withMessage('Latitude is required')
            .isFloat({ min: 22, max: 32 }).withMessage('Latitude must be between 22 and 32'),

    check('rate')
        .optional()
        .isFloat({ min: 0, max: 5 }).withMessage('Rate must be between 0 and 5'),

    check('address')
        .optional()
        .isString().withMessage('Address must be a string')
        .isLength({ min: 3, max: 300 }).withMessage('Address must be at least 3 and not exceed 300 characters long'),

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


