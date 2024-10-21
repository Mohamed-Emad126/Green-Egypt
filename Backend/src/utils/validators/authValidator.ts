import { check } from "express-validator";
import { validatorMiddleware } from "../../middlewares/validatorMiddleware";
import User from "../../models/userModel";
import sendEmail from "../email";

export const createUserValidator = [
    check("username")
    .notEmpty()
    .withMessage("username is required")
    .isLength({ min: 3, max: 15 })
    .withMessage("username must be between 3 and 15 characters"),

    check("email")
    .notEmpty()
    .withMessage("Email is required")
    .isEmail()
    .withMessage("Invalid email address")
    .custom(async (email) => {
    const existingUser = await User.findOne({ email });
    if (existingUser) {
        throw new Error("Email already in use");
    }
    return true;
    }),

    check("password")
    .notEmpty()
    .withMessage("Password is required")
    .isLength({ min: 8 })
    .withMessage("Password must be at least 8 characters long")
    .custom((password, { req }) => {
    if (password !== req.body.passwordConfirmation) {
        throw new Error("passwords do not match");
    }
    return true;
    }),

    check("passwordConfirmation")
    .notEmpty()
    .withMessage("Confirm password is required"),

    validatorMiddleware,
];

export const loginValidator = [
    check("email")
    .notEmpty()
    .withMessage("Email is required")
    .isEmail()
    .withMessage("Please enter a valid email address"),

    check("password")
    .notEmpty()
    .withMessage("Password is required")
    .isLength({ min: 8 })
    .withMessage("Password must be at least 8 characters long"),

    validatorMiddleware,
];

export const resetPasswordValidator = [
    check("email")
    .notEmpty()
    .withMessage("Email is required")
    .isEmail()
    .withMessage("Please enter a valid email address"),

    validatorMiddleware,
];

export const updatePasswordValidator = [
    check('password')
        .notEmpty().withMessage('Password is required')
        .isLength({min : 8}).withMessage('Password must be at least 8 characters long')
        .custom((password, { req }) => {
            if(password !== req.body.passwordConfirmation) {
                throw new Error('passwords do not match');
            }
            return true;
        }),

    check('passwordConfirmation')
        .notEmpty().withMessage('Confirm password is required'),

    validatorMiddleware,
];
