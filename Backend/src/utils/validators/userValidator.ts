import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';
import User from '../../models/userModel';
import bcrypt from 'bcryptjs';

export const getUserValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),
    validatorMiddleware
];

export const updateUserValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),

    check('username')
        .optional()
        .isLength({min : 3, max : 15}).withMessage('username must be between 3 and 15 characters'),
    
    check('email')
        .optional()
        .isEmail().withMessage('Please enter a valid email address'),

    validatorMiddleware
];

export const changeUserPasswordValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),

    check('currentPassword')
        .notEmpty().withMessage('Current password is required'),

    check('newPassword')
        .notEmpty().withMessage('New password is required')
        .isLength({min : 8}).withMessage('New password must be at least 8 characters long')
        .custom(async (val, { req }) => {
            const user = await User.findById(req.params!.id);
            if(!user) {
                throw new Error('User not found');
            }

            const isPasswordMatch = await bcrypt.compare(req.body.currentPassword, user.password);
            if(!isPasswordMatch) {
                throw new Error('Current password is incorrect');
            }
            
            if(val !== req.body.confirmNewPassword) {
                throw new Error('New passwords do not match');
            }

            return true;
        }),

    check('confirmNewPassword')
        .notEmpty().withMessage('Confirm new password is required'),
        
    validatorMiddleware
]

export const deleteUserValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),
    validatorMiddleware
];

export const uploadUserImageValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),
    validatorMiddleware
];

export const deleteUserImageValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),
    validatorMiddleware
];

export const updateUserPointsValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),

    check('activity')
    .notEmpty().withMessage('Activity is required')
    .isIn(['locate', 'report', 'care', 'plant']).withMessage('Invalid activity'),

    validatorMiddleware
];

