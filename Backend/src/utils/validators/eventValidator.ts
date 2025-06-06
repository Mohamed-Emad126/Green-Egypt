import { check } from 'express-validator';
import { validatorMiddleware } from '../../middlewares/validatorMiddleware';
import { get } from 'http';



export const getEventValidator = [
    check('id').isMongoId().withMessage('Invalid event ID Format'),

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

    check('timeFilter')
        .optional()
        .isIn(['thisWeek', 'nextWeek','thisMonth']).withMessage('Invalid time filter'),

    validatorMiddleware
];

export const getUserInterestedEventsValidator = [
    check('id').isMongoId().withMessage('Invalid User ID Format'),
    validatorMiddleware
];

export const createEventValidator = [
    check('eventName')
        .notEmpty().withMessage('Event Name is required')
        .isString().withMessage('Event Name must be a string'),

    check('eventDate')
        .notEmpty().withMessage('Event Date is required')
        .isISO8601().withMessage('Event Date must be a valid ISO 8601 date format (YYYY-MM-DD)')
        .isAfter(new Date().toISOString()).withMessage('Expiry date must be in the future'),

    check('description')
        .notEmpty().withMessage('Event Description is required')
        .isString().withMessage('Event Name must be a string'),

    check('location')
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

    check('organizedWithPartnerID')
        .notEmpty().withMessage('Organized With Partner ID is required'),

    check('eventStatus')
        .notEmpty().withMessage('Event status is required')
        .isIn(['upcoming' , 'ongoing' , 'completed' , 'cancelled']).withMessage('Invalid event status'),

    check('city')
        .notEmpty().withMessage('City is required')
        .isString().withMessage('Event Name must be a string'),
        
    validatorMiddleware
];

export const updateEventValidator = [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),

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

    check('eventName')
        .optional()
        .isString().withMessage('Event Name must be a string'),

    check('eventDate')
        .optional()
        .isISO8601().withMessage('Event Date must be a valid ISO 8601 date format (YYYY-MM-DD)'),

    check('description')
        .optional()
        .isString().withMessage('Event Name must be a string'),

    check('eventStatus')
        .optional()
        .isIn(['upcoming' , 'ongoing' , 'completed' , 'cancelled']).withMessage('Invalid event status'),
        
    check('organizedWithPartnerID')
        .optional()
        .isMongoId().withMessage('Invalid Organized With Partner ID Format'),

    check('city')
        .optional()
        .isString().withMessage('Event Name must be a string'),

    validatorMiddleware
];

export const deleteEventValidator = [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),

    validatorMiddleware
];

export const uploadEventImageValidator = [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),

    check('image').notEmpty().withMessage('Image is required'),
    
    validatorMiddleware
];

export const addInterestedValidator = [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),
    check('interestedUser').notEmpty().withMessage('Interested User is required'),
    validatorMiddleware
];

export const removeInterestedValidator = [
    check('id').isMongoId().withMessage('Invalid Event ID Format'),
    check('interestedUser').notEmpty().withMessage('Interested User is required'),
    validatorMiddleware
];