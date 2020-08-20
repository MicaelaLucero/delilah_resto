require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const product_router = require("./api/product/product.router");
const user_router = require("./api/user/user.router");
const order_router = require("./api/order/order.router");

app.use(bodyParser.json());
app.use("/api/product", product_router);
app.use("/api/user", user_router);
app.use("/api/order", order_router);

app.get("/api", (req, res) => {
    res.json({
        success: 1,
        message: "Api is up"
    });
});

app.listen(process.env.APP_PORT, () => {
    console.log("Server running on port: ", process.env.APP_PORT);
});