import axios from 'axios';
import FormData from 'form-data';
import fs from 'fs';
import { IObjectDetectionResponse } from '../interfaces/iOdModel';

const OBJECT_DETECTION_API_URL = process.env.OBJECT_API_URL || 'http://127.0.0.1:4000/predict';

export default class ObjectDetectionService {
    
    async detectObjects(imagePath: string) {
        const form = new FormData();
        form.append('file', fs.createReadStream(imagePath));

        try {
            const response = await axios.post<IObjectDetectionResponse>(
                OBJECT_DETECTION_API_URL,
                form,
                {
                    headers: { ...form.getHeaders() },
                    timeout: 15000
                }
            );

            fs.unlinkSync(imagePath);

            return { status: 200, data: response.data };

        } catch (error: any) {
            fs.unlinkSync(imagePath);
            return { status: error.response?.status || 500, error: error.message };
        }
    }
}