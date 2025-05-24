import TaskService from "../services/taskService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";
import { Result } from "express-validator";



export default class TaskController {

    constructor(private taskService: TaskService) {
        this.createTask = this.createTask.bind(this);
        this.markTask = this.markTask.bind(this);
        this.deleteTask = this.deleteTask.bind(this);
        this.getUserTreesWithTasks = this.getUserTreesWithTasks.bind(this);
        this.deleteAllTreeTasks = this.deleteAllTreeTasks.bind(this);
    }

    /**
     * @desc      create a new task for a user and a tree
     * @route     GET /api/users/:id/tasks
     * @param     {string} id - user id
     * @access    Private
    */
    createTask = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.taskService.createTask(req.params.id, req.body.treeID, req.body.title);
        if (result.status === 404) {
            return next(new ApiError(result.msg!, 404));
        } else if (result.status === 403) {
            return next(new ApiError(result.msg!, 403));
        } else {
            res.status(201).json({massage: result.msg , task: result.task?.title});
        }
    });

    /**
     * @desc      mark a task as done or not done
     * @route     POST /api/tasks/:id
     * @param     {string} id - task id
     * @access    Private
    */
    markTask = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.taskService.markTask(req.params.id);
        res.status(200).json({massage: result});
    });

    /**
     * @desc      delete a task
     * @route     DELETE /api/tasks/:id
     * @param     {string} id - task id
     * @access    Private
    */
    deleteTask = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        await this.taskService.deleteTask(req.params.id);
        res.json({massage: "Task deleted successfully"});
    });

    /**
     * @desc      get all list of tasks for a user tree
     * @route     GET /api/users/:id/tasks
     * @param     {string} id - user id
     * @access    Private
    */
    getUserTreesWithTasks = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const tasks = await this.taskService.getUserTreesWithTasks(req.params.id, req.body.treeIDs);
        if (tasks.length === 0) {
            res.json({massage: 'There are no tasks today'});
        }
        res.json(tasks);
    });

    /**
     * @desc      Delete all tree tasks
     * @route     GET /api/tasks/:id
     * @param     {string} id - tree id
     * @access    Private
    */
    deleteAllTreeTasks = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.taskService.deleteAllTreeTasks(req.params.id);
        if (!result) {
            next(new ApiError("Tree not found", 404));
        }
        res.json({massage: 'Tasks deleted successfully'});
    });
}
