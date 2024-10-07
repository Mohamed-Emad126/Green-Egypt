class ApiError extends Error {

    public status: string
    public operational: boolean

    constructor(message: string, public statusCode: number) {
        super(message);
        this.name = this.constructor.name;
        this.statusCode = statusCode;
        this.status = `${statusCode}`.startsWith('4') ? 'fail' : 'error';
        this.operational = true;
    }

}

export default ApiError;