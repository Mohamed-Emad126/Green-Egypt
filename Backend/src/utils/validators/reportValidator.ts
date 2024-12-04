import { check } from "express-validator";
import { validatorMiddleware } from "../../middlewares/validatorMiddleware";
import Tree from "../../models/treeModel";

export const getReportValidator = [
    check('id').isMongoId().withMessage('Invalid report ID Format'),
    validatorMiddleware
]

export const createReportValidator = [
    check('reportType')
        .notEmpty().withMessage('Report type is required')
        .isIn(['A tree needs care', 'A place needs tree', 'Other']).withMessage('Invalid report type'),

    check('location.latitude')
        .optional()
        .isFloat({ min: 22, max: 32 }).withMessage('Latitude must be between 22 and 32'),
        
    check('location.longitude')
        .optional()
        .isFloat({ min: 24, max: 37 }).withMessage('Longitude must be between 24 and 37'),

    check('treeID')
        .notEmpty().withMessage('Tree ID is required')
        .isMongoId().withMessage('Invalid tree ID Format')
        .custom(async (treeId) => {
            const tree = await Tree.findById(treeId);
            if(!tree) {
                throw new Error('Tree not found');
            }

            return true;
        }),
    
    check('description')
        .notEmpty().withMessage('Description is required')
        .isLength({max : 600}).withMessage('Description must be at most 500 characters long'),

    //check('images').notEmpty().withMessage('Image/images is required'),

    validatorMiddleware
];

export const updateReportValidator = [
    check('reportType')
        .optional()
        .isIn(['A tree needs care', 'A place needs tree', 'Other']).withMessage('Invalid report type'),

    check('location.latitude')
        .optional()
        .isFloat({ min: -90, max: 90 }).withMessage('Latitude must be between -90 and 90'),
        
    check('location.longitude')
        .optional()
        .isFloat({ min: -180, max: 180 }).withMessage('Longitude must be between -180 and 180'),

    check('treeID')
        .optional()
        .isMongoId().withMessage('Invalid tree ID Format')
        .custom(async (treeId) => {
            const tree = await Tree.findById(treeId);
            if(!tree) {
                throw new Error('Tree not found');
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
        if (!req.file) {
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

