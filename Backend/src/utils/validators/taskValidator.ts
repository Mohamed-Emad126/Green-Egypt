import { check } from "express-validator";
import { validatorMiddleware } from "../../middlewares/validatorMiddleware";
import Tree from "../../models/treeModel";

export const createTaskValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),

    check('treeID')
    .notEmpty().withMessage('Tree ID is required')
    .isMongoId().withMessage('Invalid tree ID Format'),

    check('title')
    .notEmpty().withMessage('Title is required')
    .isIn(['Water the tree', 'Prune dead branches', 'Check for pests', 'Fertilize the soil']).withMessage('Invalid task title'),

    validatorMiddleware
];

export const markTaskValidator = [
    check('id').isMongoId().withMessage('Invalid task ID Format'),
    validatorMiddleware
];

export const deleteTaskValidator = [
    check('id').isMongoId().withMessage('Invalid task ID Format'),
    validatorMiddleware
];

export const getUserTreesWithTasksValidator = [
    check('id').isMongoId().withMessage('Invalid user ID Format'),

    check('treeIDs')
        .isArray({ min: 1 }).withMessage('Tree IDs must be provided as an array')
        .custom((treeIDs) => {
            const uniqueIDs = [...new Set(treeIDs)];
            return uniqueIDs.length === treeIDs.length;
        }).withMessage('Tree IDs must be unique'),

    check('treeIDs.*')
        .isMongoId().withMessage('Invalid tree ID Format')
        .custom(async (id) => {
            const existingTree = await Tree.findOne({ _id : id });
            if (!existingTree) {
                throw new Error(`Tree with ID ${id} does not exists`);
            }
            return true;
        }),
        

    validatorMiddleware
];

export const deleteAllTreeTasksValidator = [
    check('id').isMongoId().withMessage('Invalid tree ID Format'),
    validatorMiddleware
];

