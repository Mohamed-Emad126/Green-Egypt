import mongoose, { Schema, Model } from 'mongoose';
import { ITask } from '../interfaces/iTask';

const TaskSchema: Schema = new Schema({
    title: {
        type: String,
        enum: ['Water the tree', 'Prune dead branches', 'Check for pests', 'Fertilize the soil'],
        required: true,
    },
    tree: {
        type: mongoose.Types.ObjectId,
        ref : 'Tree',
        required: true,
    },
    user: {
        type: mongoose.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    date: {
        type: Date,
        required: true,
    },
    isDone: {
        type: Boolean,
        default: false
    }
    
});

const TaskModel: Model<ITask> = mongoose.model<ITask>('Task', TaskSchema);
export default TaskModel;