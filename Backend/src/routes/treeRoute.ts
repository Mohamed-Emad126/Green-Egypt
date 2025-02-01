import { Router } from "express";
import TreeService from "../services/treeService";
import TreeController from "../controllers/treeController";
import { getTreeValidator, updateTreeValidator, deleteTreeValidator, uploadTreeImageValidator } from "../utils/validators/treeValidator";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyToken } from "../middlewares/authMiddleware";

const treeRouter = Router();

const treeService = new TreeService();
const { getTrees,
        getTreeById,
        updateTree, 
        deleteTree,
        uploadTreePicture} = new TreeController(treeService);

treeRouter.route('/')
        .get(getTrees);
        

treeRouter.route('/:id')
        .get(verifyToken, getTreeValidator, getTreeById)
        .patch(verifyToken, updateTreeValidator, updateTree)
        .delete(verifyToken, deleteTreeValidator, deleteTree);

treeRouter.route('/:id/image')
        .post(verifyToken, uploadImage, uploadTreeImageValidator, uploadTreePicture)


export default treeRouter;

