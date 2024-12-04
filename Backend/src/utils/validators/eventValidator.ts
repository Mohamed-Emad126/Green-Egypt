import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';



export const getEventValidator = [
    check('id').isMongoId().withMessage('Invalid event ID Format'),
    validatorMiddleware
];

export const createEventValidator = [
    check('eventName').notEmpty().withMessage('Event Name is required'),

    check('eventDate').notEmpty().withMessage('Event Date is required'),

    check('description').notEmpty().withMessage('Event Description is required'),

    check('location').notEmpty().withMessage('Location is required'),

    check('organizedWithPartnerID').notEmpty().withMessage('Organized With Partner ID is required'),

    check('eventStatus')
        .notEmpty().withMessage('Event status is required')
        .isIn(['upcoming' , 'ongoing' , 'completed' , 'cancelled']).withMessage('Invalid event status'),
        
        validatorMiddleware
];

export const updateEventValidator = [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),

    check('eventStatus')
        .notEmpty().withMessage('Event status is required')
        .isIn(['upcoming' , 'ongoing' , 'completed' , 'cancelled']).withMessage('Invalid event status'),

    validatorMiddleware
];

export const deleteEventValidator= [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),

    validatorMiddleware
];

export const uploadEventImageValidator = [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),

    check('image').notEmpty().withMessage('Image is required'),
    
    validatorMiddleware
];

export const deleteEventPictureValidator = [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),    
    validatorMiddleware
];