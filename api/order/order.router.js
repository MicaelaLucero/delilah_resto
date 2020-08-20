const controller = require("./order.controller");
const router = require("express").Router();
const { getAuthorizationAdmin, getAuthorizationUser} = require("../../config/token_validation");

router.post("/", getAuthorizationUser, controller.create);
router.put("/id/", getAuthorizationAdmin, controller.updateStatus);
router.get("/", getAuthorizationAdmin, controller.getAll);

module.exports = router;