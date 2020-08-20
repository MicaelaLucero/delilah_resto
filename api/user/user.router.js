const controller = require("./user.controller");
const router = require("express").Router();
const { getAuthorizationAdmin, getAuthorizationUser} = require("../../config/token_validation");

router
    .post("/", controller.createUser)
    .get("/", getAuthorizationAdmin, controller.getAllUsers)
    .get("/id", getAuthorizationUser, controller.getUserbyID)
    .post("/login", controller.login);

module.exports = router;