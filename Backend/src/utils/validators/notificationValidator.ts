import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';

export const createNotificationValidator = [
    check('userId').isMongoId().withMessage('Invalid user ID Format'),
    check('type').not().isEmpty().withMessage('Type is required'),
    check('title').not().isEmpty().withMessage('Title is required'),
    check('message').not().isEmpty().withMessage('Message is required'),
    validatorMiddleware
];

export const sendNotificationValidator = [
    check('userId').isMongoId().withMessage('Invalid user ID Format'),
    check('title').not().isEmpty().withMessage('Title is required'),
    check('message').not().isEmpty().withMessage('Message is required'),
    validatorMiddleware
];

export const sendNotificationwithSaveValidator =[
    check('userId').isMongoId().withMessage('Invalid user ID Format'),
    check('type').not().isEmpty().withMessage('Type is required'),
    check('title').not().isEmpty().withMessage('Title is required'),
    check('message').not().isEmpty().withMessage('Message is required'),
    validatorMiddleware
];

export const getUserNotificationsValidator = [
    check('userId').isMongoId().withMessage('Invalid user ID Format'),
    validatorMiddleware
];

export const markAsReadValidator =[
    check('id').isMongoId().withMessage('Invalid event ID Format'),
    validatorMiddleware
];

export const deleteNotificationValidator = [
    check('id').isMongoId().withMessage('Invalid notification ID Format'),
    validatorMiddleware
];

export const deleteAllNotificationsValidator = [
    check('userId').isMongoId().withMessage('Invalid user ID Format'),
    validatorMiddleware
];