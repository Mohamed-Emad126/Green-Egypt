import { Router } from "express";
import { verifyTaskOwnerMiddleware } from "../middlewares/authMiddleware";
import TaskController from "../controllers/taskController";
import TaskService from "../services/taskService";
import { updateTitleValidator, deleteTaskValidator, doneTaskValidator} from "../utils/validators/taskValidator";

const TaskRouter = Router();

const taskService = new TaskService();
const { updateTaskTitle, doneTask,  deleteTask } = new TaskController(taskService);

TaskRouter.route('/:id')
    .post(verifyTaskOwnerMiddleware, doneTaskValidator, doneTask)
    .patch(verifyTaskOwnerMiddleware, updateTitleValidator, updateTaskTitle)
    .delete(verifyTaskOwnerMiddleware, deleteTaskValidator, deleteTask)


export default TaskRouter;