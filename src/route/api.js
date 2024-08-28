import express, { request } from "express";
import apiController from "../controller/apiControllers";

const router = express.Router();

const initApiRoute = (app) => {
    router.get('/test', apiController.test);
    router.post('/signup', apiController.signup);
    return app.use('/api', router);
}

module.exports = initApiRoute;