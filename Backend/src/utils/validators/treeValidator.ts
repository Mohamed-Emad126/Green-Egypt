import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';



export const getTreeValidator = [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),
    validatorMiddleware
];

export const locateTreeValidator = [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),

    check('treeName')
        .optional()
        .isString().withMessage('Tree name must be a string')
        .isLength({max : 15}).withMessage('Tree name must be at most 15 characters long'),

    check('treeLocation')
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

    check('healthStatus')
        .notEmpty().withMessage('Health status is required')
        .isIn(['Healthy', 'Diseased', 'Dying']).withMessage('Invalid health status'),

    check('problem')
        .custom((value, { req }) => {
            const healthStatus = req.body.healthStatus;
            if ((healthStatus === 'Diseased' || healthStatus === 'Dying') && !value) {
                throw new Error('Problem description is required for Diseased/Dying trees');
            }
            return true;
        }),

    check('image').custom((_, { req }) => {
        if (!req.file) {
            throw new Error("Image is required");
        }
        return true;
    }),

    validatorMiddleware
];

export const updateTreeValidator = [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),

    check('treeLocation')
        .optional()
        .isObject().withMessage('Location must be an object'),

    check('treeLocation.type')
        .if(check('treeLocation').exists())
        .notEmpty().withMessage('Location type is required')
        .equals('Point').withMessage('Location must be a Point'),
        
    check('treeLocation.coordinates')
        .if(check('treeLocation').exists())
        .notEmpty().withMessage('Location coordinates is required')
        .isArray().withMessage('Location must be an array')
        .isLength({min : 2, max : 2}).withMessage('Location must have exactly two elements'),
        
    check('treeLocation.coordinates.0')
        .if(check('treeLocation.coordinates').exists())
        .notEmpty().withMessage('Longitude is required')
        .isFloat({ min: 24, max: 37 }).withMessage('Longitude must be between 24 and 37'),

    check('treeLocation.coordinates.1')
        .if(check('treeLocation.coordinates').exists())
        .notEmpty().withMessage('Latitude is required')
        .isFloat({ min: 22, max: 32 }).withMessage('Latitude must be between 22 and 32'),

    check('healthStatus')
        .optional()
        .isIn(['Healthy', 'Diseased', 'Dying']).withMessage('Invalid health status')
        .custom((val, { req }) => {
            if(val === 'Diseased' || val === 'Dying') {
                if(!req.body.problem) {
                    throw new Error('Problem is required');
                }
            }
            return true;
        }),

    validatorMiddleware
];

export const deleteTreeValidator= [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),

    check('deletionReason')
        .notEmpty().withMessage('Deletion reason is required')
        .isIn(['Died', 'Cut', 'False Record']).withMessage('Invalid deletion reason'),

    validatorMiddleware
];

export const uploadTreeImageValidator = [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),

    check('image').custom((_, { req }) => {
        if (!req.file) {
            throw new Error("Image is required");
        }
        return true;
    }),

    validatorMiddleware
];