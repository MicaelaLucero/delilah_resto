const controller = require("./product.controller");
const router = require("express").Router();
const { getAuthorizationAdmin} = require("../../config/token_validation");

router.get("/id", controller.getByID);
router.get("/", controller.getAll);
router.post("/", getAuthorizationAdmin, controller.create);
router.put("/id", getAuthorizationAdmin, controller.update);
router.delete("/id", getAuthorizationAdmin, controller.delete);

module.exports = router;