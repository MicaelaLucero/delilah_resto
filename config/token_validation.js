const { verify } = require("jsonwebtoken");

module.exports = {
    getAuthorizationAdmin: (req, res, next) => {
        let token = req.get('authorization');
        if (typeof token !== 'undefined') {
            try {
                const tokenArray = token.split(' ');
                token = tokenArray[1];
                const data = verify(token, process.env.JWT_SECRET);
                let result = data.result;
                
                if (result.id_role === 1) {
                    next();
                } else {
                    res.status(401).json({
                        success: 0,
                        message: "You need administrator privileges"
                    })
                }
            } catch (error) {
                console.log(error.message);
                res.status(500).json({
                    success: 0,
                    message: "Server error"
                })
            }
        } else {
            res.status(400).json({
                success: 0,
                message: "Should have authorization token"
            })
        }
    },
    getAuthorizationUser: (req, res, next) => {
        let token = req.get('authorization');
        if (typeof token !== 'undefined') {
            try {
                const tokenArray = token.split(' ');
                token = tokenArray[1];
                const data = verify(token, process.env.JWT_SECRET);
                let result = data.result;

                if (result.id_role === 1 || result.id_user === req.body.id_user) {
                    next();
                } else {
                    res.status(401).json({
                        success: 0,
                        message: "Access denied! Unauthorized user"
                    })
                }
            } catch (error) {
                console.log(error.message);
                res.status(500).json({
                    success: 0,
                    message: "Server error"
                })
            }
        } else {
            res.status(400).json({
                success: 0,
                message: "Should have authorization token"
            })
        }
    }
}