import { Router } from "express";
import NurseryService from "../services/nurseryService";
import NurseryController from "../controllers/nurseryController";
import {getAllNurseriesValidator, getNurseryValidator, createNurseryValidator, deleteNurseryValidator, updateNurseryValidator, uploadNurseryPictureValidator} from "../utils/validators/nurseryValidator";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyToken, verifyAdminMiddleware } from "../middlewares/authMiddleware";

const nurseryRouter = Router();

const nurseryService = new NurseryService();
const { getNurseries, 
        getNurseryById,
        createNursery, 
        deleteNursery, 
        updateNursery, 
        uploadNurseryPicture} = new NurseryController(nurseryService);

nurseryRouter.route('/')
        .get(verifyToken, getAllNurseriesValidator, getNurseries)
        .post(verifyAdminMiddleware, createNurseryValidator, createNursery);

nurseryRouter.route('/:id')
        .get(verifyToken, getNurseryValidator, getNurseryById)
        .patch(verifyAdminMiddleware, updateNurseryValidator, updateNursery)
        .delete(verifyAdminMiddleware, deleteNurseryValidator, deleteNursery);

nurseryRouter.route('/image/:id')
        .post(verifyAdminMiddleware, uploadImage, uploadNurseryPictureValidator, uploadNurseryPicture) 


export default nurseryRouter;



