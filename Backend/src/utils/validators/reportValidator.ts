import { check } from "express-validator";
import { validatorMiddleware } from "../../middlewares/validatorMiddleware";

export const getReportValidator = [
    check('id').isMongoId().withMessage('Invalid report ID Format'),

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
]

export const createReportValidator = [
    check('reportType')
        .notEmpty().withMessage('Report type is required')
        .isIn(['A tree needs care', 'A place needs tree', 'Other']).withMessage('Invalid report type'),

    check('location')
        .if(check('reportType').isIn(['A place needs tree']))
        .notEmpty().withMessage('Location is required')
        .custom((value) => {
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
    }),

    check('treeID')
        .if(check('reportType').isIn(['A tree needs care']))
        .notEmpty().withMessage('Tree ID is required')
        .isMongoId().withMessage('Invalid tree ID Format'),
    
    check('description')
        .notEmpty().withMessage('Description is required')
        .isLength({max : 600}).withMessage('Description must be at most 500 characters long'),

    check('images').custom((_, { req }) => {
        if (!req.files || req.files.length === 0) {
            throw new Error("at least one image is required");
        }
        return true;
    }),

    validatorMiddleware
];

export const updateReportValidator = [
    check('reportType')
        .optional()
        .isIn(['A tree needs care', 'A place needs tree', 'Other']).withMessage('Invalid report type'),

    check('location')
        .custom((value, { req }) => {
            if (req.body.reportType === 'A place needs tree') {
                if (!value || typeof value !== 'object' || !value.type || !value.coordinates) {
                    throw new Error('Location is required and must be a valid object for "A place needs tree"');
                }
            }
            return true;
        }),

    check('location.type')
        .if(check('location').exists())
        .notEmpty().withMessage('Location type is required')
        .isIn(['Point']).withMessage('Location must be a Point'),
        
    check('location.coordinates')
        .if(check('location').exists())
        .notEmpty().withMessage('Location coordinates is required')
        .isArray().withMessage('Location must be an array')
        .isLength({min : 2, max : 2}).withMessage('Location must have exactly two elements'),
        
    check('location.coordinates.0')
        .if(check('location.coordinates').exists())
        .notEmpty().withMessage('Longitude is required')
        .isFloat({ min: 24, max: 37 }).withMessage('Longitude must be between 24 and 37'),

    check('location.coordinates.1')
        .if(check('location.coordinates').exists())
        .notEmpty().withMessage('Latitude is required')
        .isFloat({ min: 22, max: 32 }).withMessage('Latitude must be between 22 and 32'),

    check('treeID')
        .custom((value, { req }) => {
            if (req.body.reportType === 'A tree needs care') {
                if (!value) {
                    throw new Error('treeID is required for "A tree needs care"');
                }
                const mongoose = require('mongoose');
                if (!mongoose.Types.ObjectId.isValid(value)) {
                    throw new Error('Invalid tree ID format');
                }
            }
            return true;
        }),
    
    check('description')
        .optional()
        .isLength({max : 600}).withMessage('Description must be at most 500 characters long'),

    validatorMiddleware
];

export const uploadReportImagesValidator = [
    check('id').isMongoId().withMessage('Invalid report ID Format'),

    check('images').custom((_, { req }) => {
        if (!req.files || req.files.length === 0) {
            throw new Error("at least one image is required");
        }
        return true;
    }),

    validatorMiddleware
]

export const deleteReportImageValidator = [
    check('id').isMongoId().withMessage('Invalid report ID Format'),

    check('imagePath').isString().withMessage('Image path is required'),
    
    validatorMiddleware
];

export const deleteReportValidator = [
    check('id').isMongoId().withMessage('Invalid report ID Format'),
    validatorMiddleware
];

export const toggleUpvoteValidator = [
    check('id').isMongoId().withMessage('Invalid report ID Format'),
    validatorMiddleware
];

export const registerVolunteeringValidator = [
    check('id').isMongoId().withMessage('Invalid report ID Format'),
    validatorMiddleware
];

export const saveReportValidator = [
    check('id').isMongoId().withMessage('Invalid report ID Format'),
    validatorMiddleware
];

