import { Router } from "express";
import PartnerService from "../services/partnerService";
import PartnerController from "../controllers/partnerController";
import { getPartnerValidator, createNewPartnerValidator, updatePartnerValidator, deletePartnerValidator, uploadPartnerLogoValidator } from "../utils/validators/partnerValidator";
import { verifyAdminMiddleware, verifyToken } from "../middlewares/authMiddleware";
import { uploadImage } from "../middlewares/uploadImageMiddleware";



const partnerRoute = Router();

const partnerService = new PartnerService();
const { getPartners,
        getPartnerById, 
        createNewPartner,
        updatePartner,
        deletePartner,
        uploadPartnerLogo} = new PartnerController(partnerService);

partnerRoute.route('/')
        .get(verifyToken, getPartners)
        .post(verifyAdminMiddleware, uploadImage, createNewPartnerValidator, createNewPartner);

partnerRoute.route('/:id')
        .get(verifyToken, getPartnerValidator, getPartnerById)
        .patch(verifyAdminMiddleware, updatePartnerValidator, updatePartner)
        .delete(verifyAdminMiddleware, deletePartnerValidator, deletePartner);

partnerRoute.route('/:id/image')
        .patch(verifyAdminMiddleware, uploadImage, uploadPartnerLogoValidator, uploadPartnerLogo);

export default partnerRoute;