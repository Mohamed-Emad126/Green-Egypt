import { Router } from "express";
import NurseryService from "../services/nurseryService";
import NurseryController from "../controllers/nurseryController";
import {getNurseryValidator,createNurseryValidator ,deleteNurseryValidator ,updateNurseryValidator ,uploadNurseryPictureValidator} from "../utils/validators/nurseryValidator";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyToken } from "../middlewares/authMiddleware";

const nurseryRouter = Router();

const nurseryService = new NurseryService();
const { getNurseries, 
        getNurseryById,
        createNursery, 
        deleteNursery, 
        updateNursery, 
        uploadNurseryPicture} = new NurseryController(nurseryService);

nurseryRouter.route('/')
        .get(getNurseries)
        .post(verifyToken,createNurseryValidator, createNursery);

nurseryRouter.route('/:id')
        .get(verifyToken, getNurseryValidator, getNurseryById)
        .patch(verifyToken, updateNurseryValidator, updateNursery)
        .delete(verifyToken, deleteNurseryValidator, deleteNursery);

nurseryRouter.route('/image/:id')
        .post(verifyToken, uploadImage, uploadNurseryPictureValidator, uploadNurseryPicture) 


export default nurseryRouter;



