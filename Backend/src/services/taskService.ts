import User from "../models/userModel";
import Task from "../models/taskModel";
import Tree from "../models/treeModel";


export default class TaskService {

    async createTask(userID: string, treeID: string, title: string) {
        const user = await User.findById(userID);
        const tree = await Tree.findById(treeID);
        if (!user) {
            return { status: 404, msg:'User not found'};
        } else if (!tree) {
            return { status: 404, msg:'Tree not found'};
        } else if (!tree.plantedRecently || tree.byUser.toString() !== userID) {
            return { status: 403, msg:'This tree not belongs to this user'};
        }

        const startOfDay = new Date();
        startOfDay.setHours(0, 0, 0, 0);
    
        const endOfDay = new Date(startOfDay);
        endOfDay.setHours(23, 59, 59, 999);
        
        const isTaskExists = await Task.findOne({ user, tree, date : { $gte: startOfDay, $lte: endOfDay}, title });
        if (isTaskExists) {
            return { status: 400, msg:'Task already exists'};
        }

        const task =  await Task.create({ user, tree, date : new Date(), title });
        return { status: 201, msg:'Task created successfully', task };
        
    }

    async markTask(taskID: string) {
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


    async getUserTreesWithTasks(userID: string, treeIDs: string[]) {
        const startOfDay = new Date();
        startOfDay.setHours(0, 0, 0, 0);
    
        const endOfDay = new Date(startOfDay);
        endOfDay.setHours(23, 59, 59, 999);
    
        const tasksPromises = treeIDs.map(async (treeID) => {
            const tasks = await Task.find({
                user: userID,
                tree: treeID,
                date: { $gte: startOfDay, $lte: endOfDay }
            }).populate('tree', 'treeName')
            .lean();
    
            if (tasks.length === 0) return null;
    
            return {
                treeID,
                treeName: (tasks[0].tree as any).treeName,
                pendingTasks: tasks.filter(task => !task.isDone),
                completedTasks: tasks.filter(task => task.isDone)
            };
        });
    
        const treesWithTasks = await Promise.all(tasksPromises);
    
        return treesWithTasks.filter(tree => tree !== null);
    }
    

    async deleteAllTreeTasks(treeID: string) {
        const tree = await Tree.findById(treeID);
        if (!tree) {
            return false;
        }
        await Task.deleteMany({ tree: treeID });
        return true;
    }
}