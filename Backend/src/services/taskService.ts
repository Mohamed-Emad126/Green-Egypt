import User from "../models/userModel";
import Task from "../models/taskModel";
import Tree from "../models/treeModel";


export default class TaskService {

    async createTask(userID: string, treeID: string, date: Date, title: string) {
        const user = await User.findById(userID);
        const tree = await Tree.findById(treeID);
        if (!user) {
            return { status: 404, msg:'User not found'};
        } else if (!tree) {
            return { status: 404, msg:'Tree not found'};
        }
        const task =  await Task.create({ user, tree, date, title });
        return { status: 201, msg:'Task created successfully', task };
        
    }

    async doneTask(taskID: string) {
        const task = await Task.findById(taskID);

        let msg= '';
        if (task!.isDone === false) {
            task!.isDone = true;
            msg = 'Task marked as done successfully';
        } else {
            task!.isDone = false;
            msg = 'Task marked as not done successfully';
        }

        await task!.save();
        return msg;
    }

    async deleteTask(taskID: string) {
        const task = await Task.findById(taskID);
        if (!task) {
            return false;
        }
        await task.deleteOne();
        return true;
    }

    async updateTaskTitle(taskID: string, newTitle: string) {
        const task = await Task.findById(taskID);
        task!.title = newTitle;
        await task!.save();
        return task;
    }

    async getUserTasksByDate(userID: string, date: Date) {
        const user = await User.findById(userID);

        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const tasks = await Task.find({ user, date: { $gte: today } });

        if (tasks.length === 0) {
            return null;
        }

        return tasks;
    }

}