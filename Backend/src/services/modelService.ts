import axios from 'axios';
import FormData from 'form-data';
import fs from 'fs';
import { IDiseasePrediction } from '../interfaces/iModel';

const DISEASE_DETECTION_API_URL = process.env.DISEASE_API_URL || 'http://127.0.0.1:4000/predict';

export default class ModelService {

    async detectTreeDisease(imagePath: string){
        const form = new FormData();
        form.append('file', fs.createReadStream(imagePath));
        
        try {
            const response = await axios.post<IDiseasePrediction>(
                DISEASE_DETECTION_API_URL,
                form,
                {
                    headers: {...form.getHeaders()},
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