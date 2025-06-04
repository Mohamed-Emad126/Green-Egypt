import { Router } from "express";
import EventService from "../services/eventService";
import EventController from "../controllers/eventController";
import {getEventValidator, createEventValidator, deleteEventValidator, updateEventValidator, uploadEventImageValidator, addInterestedValidator, removeInterestedValidator} from "../utils/validators/eventValidator";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyAdminMiddleware, verifyToken } from "../middlewares/authMiddleware";

const eventRouter = Router();

const eventService = new EventService();
const { getEvents, 
        getEventById,
        createEvent, 
        deleteEvent, 
        updateEvent, 
        uploadEventPicture,
        addInterested,
        removeInterested} = new EventController(eventService);

eventRouter.route('/')
        .get(getEvents)
        .post(verifyAdminMiddleware, createEventValidator, createEvent);

eventRouter.route('/:id')
        .get(verifyToken, getEventValidator, getEventById)
        .patch(verifyAdminMiddleware, updateEventValidator, updateEvent)
        .delete(verifyAdminMiddleware, deleteEventValidator, deleteEvent);

eventRouter.route('/image/:id')
        .post(verifyAdminMiddleware, uploadImage, uploadEventImageValidator, uploadEventPicture)        

eventRouter.route('/:id/interested')
        .post(verifyToken, addInterestedValidator, addInterested)
        .delete(verifyToken, removeInterestedValidator, removeInterested);

export default eventRouter;



