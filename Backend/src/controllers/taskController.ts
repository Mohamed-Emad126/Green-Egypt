import TaskService from "../services/taskService";
import { Request, Response, NextFunction } from "express";
import asyncHandler from 'express-async-handler';
import ApiError from "../utils/apiError";



export default class TaskController {

    constructor(private taskService: TaskService) {
        this.createTask = this.createTask.bind(this);
        this.doneTask = this.doneTask.bind(this);
        this.updateTaskTitle = this.updateTaskTitle.bind(this);
        this.deleteTask = this.deleteTask.bind(this);
        this.getUserTasksByDate = this.getUserTasksByDate.bind(this);
    }

    /**
     * @desc      get trees that a user has planted
     * @route     GET /api/users/:id/tasks
     * @param     {string} id - user id
     * @access    Private
    */
    createTask = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.taskService.createTask(req.params.id, req.body.treeID, req.body.date, req.body.title);
        if (result.status === 404) {
            return next(new ApiError(result.msg!, 404));
        } else {
            res.status(201).json({massage: result.msg , task: result.task});
        }
    });

    /**
     * @desc      mark a task as done or not done
     * @route     POST /api/tasks/:id
     * @param     {string} id - task id
     * @access    Private
    */
    doneTask = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const result = await this.taskService.doneTask(req.params.id);
        res.status(200).json({massage: result});
    });

    /**
     * @desc      update a task title
     * @route     PUT /api/tasks/:id
     * @param     {string} id - task id
     * @access    Private
    */
    updateTaskTitle = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const taskAfterUpdate = await this.taskService.updateTaskTitle(req.params.id, req.body.title);
        res.json({massage: "Task updated successfully", task: taskAfterUpdate});
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
     * @desc      get all tasks of a user by date
     * @route     GET /api/users/:id/tasks
     * @param     {string} id - user id
     * @access    Private
    */
    getUserTasksByDate = asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
        const tasks = await this.taskService.getUserTasksByDate(req.params.id, new Date(req.params.date));
        if (tasks === null) {
            res.json({massage: 'There are no tasks on this date'});
        }
        res.json(tasks);
    });
}
