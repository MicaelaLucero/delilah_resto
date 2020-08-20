const service = require("./user.service");
const { genSaltSync, hashSync, compareSync } = require("bcrypt");
const { sign } = require("jsonwebtoken");

module.exports = {
    getUserbyID: (req, res) => {
        service.getUserByID(req.body, (err, results) => {
            if (err) {
                console.log(err);
                return res.status(500).json({
                    success: 0,
                    message: err.message
                })
            }
            return res.status(200).json({
                success: 1,
                data: results[0]
            })
        });
    },
    getAllUsers: (req, res) => {
        service.getAllUsers((err, results) => {
            if (err) {
                console.log(err);
                return res.status(500).json({
                    success: 0,
                    message: err.message
                })
            }
            return res.status(200).json({
                success: 1,
                data: results
            })
        });
    },
    createUser: (req, res) => {
        const body = req.body;
        const salt = genSaltSync(10);
        body.password = hashSync(body.password, salt);
        service.createUser(req.body, (err, results) => {
            if (err) {
                console.log(err);
                return res.status(500).json({
                    success: 0,
                    message: err.message
                })
            }
            return res.status(200).json({
                success: 1,
                data: results
            })
        });
    },
    login: (req, res) => {
        const body = req.body;
        if ((!body.email && !body.username) || !body.password) {
            return res.status(400).json({
                success: 0,
                message: "Should have either email or username, and password."
            })
        } else if (body.email) {
            service.getUserByEmail(body.email, (err, results) => {
                if (err) {
                    console.log(err);
                }
                if (results) {
                    let result = (body.password === results.password);
                    if (!result) {
                        result = compareSync(body.password, results.password);
                    }
                    if (result) {
                        results.password = undefined;
                        const token = sign({ result: results }, process.env.JWT_SECRET, { expiresIn: "1h" });
                        return res.status(200).json({
                            success: 1,
                            message: "Login successful",
                            token: token
                        });
                    }
                }
                return res.status(401).json({
                    success: 0,
                    data: "Invalid email or password"
                })
            })
        } else {
            service.getUserByUsername(body.username, (err, results) => {
                if (err) {
                    console.log(err);
                }
                if (results) {
                    let result = (body.password === results.password);
                    if (!result) {
                        result = compareSync(body.password, results.password);
                    }
                    if (result) {
                        results.password = undefined;
                        const token = sign({ result: results }, process.env.JWT_SECRET, { expiresIn: "1h" });
                        return res.status(200).json({
                            success: 1,
                            message: "Login successful",
                            token: token
                        });
                    }
                }
                return res.status(401).json({
                    success: 0,
                    data: "Invalid username or password"
                })
            })
        }
    }
}