import EventService from "../services/eventService";
import e, { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { IEventInput, IEventFilter } from "../interfaces/iEvent";


export default class EventController {

    constructor(private eventService: EventService) {
        this.getEvents = this.getEvents.bind(this);
        this.getEventById = this.getEventById.bind(this);
        this.getUserInterestedEvents = this.getUserInterestedEvents.bind(this);
        this.createEvent = this.createEvent.bind(this);
        this.updateEvent = this.updateEvent.bind(this);
        this.deleteEvent = this.deleteEvent.bind(this);
        this.uploadEventPicture = this.uploadEventPicture.bind(this);
        this.addInterested = this.addInterested.bind(this);
        this.removeInterested = this.removeInterested.bind(this);
    }

    /**
     * @desc      Get all events
     * @route     GET /api/events
     * @access    Public
    */

    getEvents = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 6;
        const filters: IEventFilter = req.body;
        const events = await this.eventService.getEvents(page, limit , filters);
        res.json({ length: events.length, page: page, events: events });
    });

    /**
     * @desc      Get 
     * @route     GET /api/users/:id/events
     * @access    Private
    */

    getUserInterestedEvents = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 6;
        const events = await this.eventService.getUserInterestedEvents(req.params.id, page, limit);
        
        if (events === false) {
            return next(new ApiError("User not found", 404));
        } else if (events === null) {
            return next(new ApiError("No interested Events", 404));
        }
        res.json({ length: events.length, page: page, events: events });
    });

    /**
     * @desc      Get event by id
     * @route     GET /api/events/:id
     * @access    Public
     */

    getEventById = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const event = await this.eventService.getEventById(req.params.id);
            if (event) {
                res.json(event);
            } else {
                return next(new ApiError("Event not found", 404));
        }
    });

    /**
     * @desc      Create event
     * @route     POST /api/events
     * @access    Public
     */
    createEvent = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const { eventName,eventDate,description,location,city,eventStatus,organizedWithPartnerID }: IEventInput = req.body;
        const event = await this.eventService.createEvent({eventName,eventDate,description,location,city,eventStatus,organizedWithPartnerID});
        if (event !== false) {
            res.json({ message: 'Event created successfully' });
        } else {
            return next(new ApiError("Partner not found", 404));
        }
    });

    /**
     * @desc      Update event
     * @route     PATCH /api/events/:id
     * @access    Public
     */

    updateEvent = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const eventAfterUpdate = await this.eventService.updateEvent(req.params.id, req.body);
        if (eventAfterUpdate.status === 200) {
            res.json({ message: eventAfterUpdate.message });
        } else {
            return next(new ApiError(eventAfterUpdate.message, 404));
        }
    });

    /**
     * @desc      Delete event
     * @route     DELETE /api/events/:id
     * @access    Public
     */

    deleteEvent = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const event = await this.eventService.deleteEvent(req.params.id, req.body.user.id);
        if (event) {
            res.json({ message: 'Event deleted successfully' });
        } else {
            return next(new ApiError("Event not found", 500));
        }
    });

    /**
     * @desc      Upload event picture
     * @route     POST /api/events/:id/picture
     * @access    Public
     */
    uploadEventPicture = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.eventService.uploadEventPicture(req.params.id, req.file);
        if (result) {
            res.json({ message: "Picture updated successfully"});
        } else {
            return next(new ApiError("Event not found", 404));
        }
    });


    /**
     * @desc      add interested user
     * @route     POST /api/events/:id/interested
     * @access    Public
     */
    addInterested = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.eventService.addInterested(req.params.id, req.body.interestedUser);
        if (result) {
            res.json({ message: "User added successfully"});
        } else {
            return next(new ApiError("Event not found", 404));
        }
    });
    
    /**
     * @desc      Remove interested user
     * @route     DELETE /api/events/:id/interested
     * @access    Public
     */
    removeInterested = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.eventService.removeInterested(req.params.id, req.body.interestedUser);
        if (result) {
            res.json({ message: "User removed successfully"});
        } else {
            return next(new ApiError("Event not found", 404));
        }
    });
}