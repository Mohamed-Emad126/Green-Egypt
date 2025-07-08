export interface IDetectedObject {
    class: string;
    confidence: number;
}

export interface IObjectDetectionResponse {
    filename: string;
    detections: IDetectedObject[];
}