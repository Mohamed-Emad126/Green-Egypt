import { Router } from "express";
import TreeService from "../services/treeService";
import TreeController from "../controllers/treeController";
import { getTreeValidator, locateTreeValidator, updateTreeValidator, deleteTreeValidator, uploadTreeImageValidator } from "../utils/validators/treeValidator";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyToken } from "../middlewares/authMiddleware";

const treeRouter = Router();

const treeService = new TreeService();
const { getTrees,
        getTreeById,
        LocateTree,
        updateTree, 
        deleteTree,
        uploadTreePicture} = new TreeController(treeService);

treeRouter.route('/')
        .get(getTrees)
        .post(verifyToken, locateTreeValidator, LocateTree);

treeRouter.route('/:id')
        .get(verifyToken, getTreeValidator, getTreeById)
        .patch(verifyToken, updateTreeValidator, updateTree)
        .delete(verifyToken, deleteTreeValidator, deleteTree);

treeRouter.route('/image/:id')
        .post(verifyToken, uploadImage, uploadTreeImageValidator, uploadTreePicture)

export default treeRouter;

