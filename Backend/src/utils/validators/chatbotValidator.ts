import { check } from "express-validator";
import { validatorMiddleware } from "../../middlewares/validatorMiddleware";

export const chatValidator = [
    check('text')
        .notEmpty()
        .withMessage("Text is required")
        .isString()
        .withMessage("Text must be a string"),

    check('user_id')
        .notEmpty()
        .withMessage("User ID is required")
        .isString()
        .withMessage("User ID must be a string"),

    validatorMiddleware
];