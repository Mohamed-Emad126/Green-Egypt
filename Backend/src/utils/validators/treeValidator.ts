import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';



export const getTreeValidator = [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),
    validatorMiddleware
];

export const locateTreeValidator = [
    check('species').notEmpty().withMessage('Species is required'),
    
    check('location').notEmpty().withMessage('Location is required'),

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

    check('image').notEmpty().withMessage('Image is required'),
    
    validatorMiddleware
];