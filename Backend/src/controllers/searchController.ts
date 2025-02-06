import SearchService from "../services/searchService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';



export default class TaskController {

    constructor(private taskService: SearchService) {
        this.searchHome = this.searchHome.bind(this);
        this.searchCommunity = this.searchCommunity.bind(this);
    }

    searchHome = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.taskService.homeSearch(req.params.key);
        if (result === 404) {
            res.status(404).json({ massage: "No result found" });
        } else {
            const articleResult = result[0].length !== 0 ? result[0] : "No articles found";
            const eventResult = result[1].length !== 0 ? result[1] : "No events found";
            res.json({ Articles: articleResult, Events: eventResult });
        }
    })

    searchCommunity = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.taskService.communitySearch(req.params.key);
        if (result === 404) {
            res.status(404).json({ massage: "No result found" });
        } else {
            const userResult = result[0].length !== 0 ? result[0] : "No users found";
            const reportResult = result[1].length !== 0 ? result[1] : "No reports found";
            res.json({ Users: userResult, Reports: reportResult });
        }
    })

}
