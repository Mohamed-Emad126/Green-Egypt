import { Router } from "express";
import { verifyTaskOwnerMiddleware, verifyTreeOwnerMiddleware } from "../middlewares/authMiddleware";
import TaskController from "../controllers/taskController";
import TaskService from "../services/taskService";
import { deleteTaskValidator, markTaskValidator, deleteAllTreeTasksValidator} from "../utils/validators/taskValidator";

const TaskRouter = Router();

const taskService = new TaskService();
const { markTask, deleteTask, deleteAllTreeTasks } = new TaskController(taskService);

TaskRouter.route('/:id')
    .post(verifyTaskOwnerMiddleware, markTaskValidator, markTask)
    .delete(verifyTaskOwnerMiddleware, deleteTaskValidator, deleteTask);

TaskRouter.route('/:id/delete-all-tasks')
    .delete(verifyTreeOwnerMiddleware, deleteAllTreeTasksValidator, deleteAllTreeTasks);


export default TaskRouter;