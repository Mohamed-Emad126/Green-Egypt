import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';



export const getTreeValidator = [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),
    validatorMiddleware
];

export const locateTreeValidator = [
    check('treeLocation')
        .notEmpty().withMessage('Location is required')
        .isObject().withMessage('Location must be an object'),

    check('treeLocation.type')
        .notEmpty().withMessage('Location type is required')
        .isIn(['Point']).withMessage('Location must be a Point'),
        
    check('treeLocation.coordinates')
        .notEmpty().withMessage('Location coordinates is required')
        .isArray().withMessage('Location must be an array')
        .isLength({min : 2, max : 2}).withMessage('Location must have exactly two elements'),
        
    check('treeLocation.coordinates.0')
        .notEmpty().withMessage('Longitude is required')
        .isFloat({ min: 24, max: 37 }).withMessage('Longitude must be between 24 and 37'),

    check('treeLocation.coordinates.1')
        .notEmpty().withMessage('Latitude is required')
        .isFloat({ min: 22, max: 32 }).withMessage('Latitude must be between 22 and 32'),

    check('healthStatus')
        .notEmpty().withMessage('Health status is required')
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

export const updateTreeValidator = [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),

    check('treeLocation')
        .optional()
        .isObject().withMessage('Location must be an object'),

    check('treeLocation.type')
        .if(check('treeLocation').exists())
        .notEmpty().withMessage('Location type is required')
        .isIn(['Point']).withMessage('Location must be a Point'),
        
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