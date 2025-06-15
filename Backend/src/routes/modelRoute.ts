import { Router } from "express";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyToken } from "../middlewares/authMiddleware";
import ModelController from "../controllers/modelController";
import ModelService from "../services/modelService";
import { detectTreeDiseaseValidator } from "../utils/validators/modelValidator";

const modelRouter = Router();

const modelService = new ModelService();
const { detectDisease } = new ModelController(modelService);

modelRouter.route('/detect-disease').post(verifyToken, uploadImage, detectTreeDiseaseValidator, detectDisease);

export default modelRouter;
