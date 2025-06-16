import { check } from "express-validator";
import { validatorMiddleware } from "../../middlewares/validatorMiddleware";

export const detectTreeDiseaseValidator = [
    check('image').custom((_, { req }) => {
        if (!req.file) {
            throw new Error("Image is required");
        }
        return true;
    }),
    
    validatorMiddleware
];