import express, { request } from "express";
import apiController from "../controller/apiControllers";

const router = express.Router();

const initApiRoute = (app) => {
    router.get('/test', apiController.test);
    router.post('/signup', apiController.signup);
    router.get('/checkexist', apiController.checkExist);
    router.post('/updatepassword', apiController.updatePassword);
    router.post('/saveuserinfo', apiController.saveUserInfo);
    return app.use('/api', router);
}

module.exports = initApiRoute;