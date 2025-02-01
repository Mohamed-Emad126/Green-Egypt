import EventService from "../services/eventService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { IEventInput } from "../interfaces/iEvent";


export default class EventController {

    constructor(private eventService: EventService) {
        this.getEvents = this.getEvents.bind(this);
        
    }

    /**
     * @desc      Get all events
     * @route     GET /api/events
     * @access    Public
    */

    getEvents = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const page: number = req.query.page ? +req.query.page : 1;
        const limit: number = req.query.limit ? +req.query.limit : 5;
        const filters = req.query.filters ? JSON.parse(req.query.filters as string) : {};
        const events = await this.eventService.getEvents(page, limit , filters);
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
        const { eventName,eventDate,description,location,eventImage,eventStatus,organizedWithPartnerID }: IEventInput = req.body;
        const event = await this.eventService.createEvent({eventName,eventDate,description,location,eventImage,eventStatus,organizedWithPartnerID});
        if (event) {
            res.json({ message: 'Event created successfully' });
        } else {
            return next(new ApiError("Error creating event", 500));
        }
    });

    /**
     * @desc      Update event
     * @route     PATCH /api/events/:id
     * @access    Public
     */

    updateEvent = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const eventAfterUpdate = await this.eventService.updateEvent(req.params.id, req.body);
        if (eventAfterUpdate) {
            res.json({ message: 'Event updated successfully' });
        } else {
            return next(new ApiError("Event not found", 404));
        }
    });

    /**
     * @desc      Delete event
     * @route     DELETE /api/events/:id
     * @access    Public
     */

    deleteEvent = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const event = await this.eventService.deleteEvent(req.params.id);
        if (event) {
            res.json({ message: 'Event deleted successfully' });
        } else {
            return next(new ApiError("Event not found", 500));
        }
    });

    /**
     * @desc      Upload event picture
     * @route     POST /api/events/:id/picture
     * @access    Puiblic
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

    /**
     * @desc      Count interested users
     * @route     GET /api/events/:id/interested/count
     * @access    Public
     */
    countInterested = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.eventService.countInterested(req.params.id);
        if (result) {
            res.json({ interestedCount: result});
        } else {
            return next(new ApiError("Event not found", 404));
        }
    });
}