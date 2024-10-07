import { Router } from "express";
import TreeService from "../services/treeService";
import TreeController from "../controllers/treeController";
import { getTreeValidator, locateTreeValidator, updateTreeValidator, deleteTreeValidator, uploadTreeImageValidator } from "../utils/validators/treeValidator";
import { uploadTreeImage } from "../middlewares/uploadImageMiddleware";

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
        .post(locateTreeValidator, LocateTree);

treeRouter.route('/:id')
        .get(getTreeValidator, getTreeById)
        .patch(updateTreeValidator, updateTree)
        .delete(deleteTreeValidator, deleteTree);

treeRouter.route('/:id/image')
        .post(uploadTreeImage, uploadTreeImageValidator, uploadTreePicture)

export default treeRouter;

