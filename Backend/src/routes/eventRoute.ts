import { Router } from "express";
import EventService from "../services/eventService";
import EventController from "../controllers/eventController";
import {getEventValidator,createEventValidator ,deleteEventValidator ,updateEventValidator ,uploadEventImageValidator,addInterestedValidator,removeInterestedValidator,countInterestedValidator} from "../utils/validators/eventValidator";
import { uploadImage } from "../middlewares/uploadImageMiddleware";
import { verifyToken } from "../middlewares/authMiddleware";

const eventRouter = Router();

const eventService = new EventService();
const { getEvents, 
        getEventById,
        createEvent, 
        deleteEvent, 
        updateEvent, 
        uploadEventPicture,
        addInterested,
        removeInterested,
        countInterested } = new EventController(eventService);

eventRouter.route('/')
        .get(getEvents)
        .post(verifyToken,createEventValidator, createEvent);

eventRouter.route('/:id')
        .get(verifyToken, getEventValidator, getEventById)
        .patch(verifyToken, updateEventValidator, updateEvent)
        .delete(verifyToken, deleteEventValidator, deleteEvent);

eventRouter.route('/image/:id')
        .post(verifyToken, uploadImage, uploadEventImageValidator, uploadEventPicture)        

eventRouter.route('/interested/:id')
        .post(verifyToken, addInterestedValidator, addInterested)
        .delete(verifyToken, removeInterestedValidator, removeInterested);

eventRouter.route('/interested/:id/count')
        .get(verifyToken, countInterestedValidator, countInterested);

export default eventRouter;



