import { Router } from "express";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyToken } from "../middlewares/authMiddleware";
import ObjectDetectionController from "../controllers/ODModelController";
import ObjectDetectionService from "../services/OdModelService";
import { detectObjectsValidator } from "../utils/validators/ODModelValidator";

const objectRouter = Router();

const service = new ObjectDetectionService();
const { detectObjects } = new ObjectDetectionController(service);

objectRouter.post('/detect-objects', verifyToken, uploadImage, detectObjectsValidator, detectObjects);

export default objectRouter;
