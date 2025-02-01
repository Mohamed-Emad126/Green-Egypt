import { check } from "express-validator";
import { validatorMiddleware } from "../../middlewares/validatorMiddleware";

export const createTaskValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),

    check('treeID')
    .notEmpty().withMessage('Tree ID is required')
    .isMongoId().withMessage('Invalid tree ID Format'),

    check('date')
    .notEmpty().withMessage('Date is required')
    .isDate().withMessage('Invalid date format')  // isISO8601()
    .custom((value) => {
        const inputDate = new Date(value);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (inputDate < today) {
            throw new Error('Date cannot be in the past');
        }
        return true;
    }),

    check('title')
    .notEmpty().withMessage('Title is required')
    .isLength({ max: 30 }).withMessage('Title must be at most 30 characters long'),

    validatorMiddleware
];

export const doneTaskValidator = [
    check('id').isMongoId().withMessage('Invalid task ID Format'),
    validatorMiddleware
];

export const updateTitleValidator = [
    check('id').isMongoId().withMessage('Invalid task ID Format'),

    check('title')
    .notEmpty().withMessage('New title is required')
    .isLength({ max: 30 }).withMessage('Title must be at most 30 characters long'),

    validatorMiddleware
];

export const deleteTaskValidator = [
    check('id').isMongoId().withMessage('Invalid task ID Format'),
    validatorMiddleware
];

export const getUserTasksByDateValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),

    check('date')
    .notEmpty().withMessage('Date is required')
    .isDate().withMessage('Invalid date format')  // isISO8601()
    .custom((value) => {
        const inputDate = new Date(value);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (inputDate < today) {
            throw new Error('Date cannot be in the past');
        }
        return true;
    }),

    validatorMiddleware
];

