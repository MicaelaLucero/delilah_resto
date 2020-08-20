const pool = require("../../config/database");

module.exports = {
    getUserByID: (data, callBack) => {
        pool.query(
            `SELECT id_user, username, email, \`user\`.name, last_name, address, phone, \`role\`.description role, \`city\`.description city 
             FROM \`user\` 
             JOIN \`role\` ON \`user\`.id_role=\`role\`.id_role 
             JOIN \`city\` ON \`user\`.id_city=\`city\`.id_city 
             WHERE id_user=?`,
            [
                data.id_user
            ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    },
    getUserByEmail: (email, callBack) => {
        pool.query(
            `SELECT * FROM \`user\` where email = ?`,
            [email],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results[0]);
            }
        )
    },
    getUserByUsername: (username, callBack) => {
        pool.query(
            `SELECT * FROM \`user\` where username = ?`,
            [username],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results[0]);
            }
        )
    },
    getAllUsers: (callBack) => {
        pool.query(
            `SELECT id_user, username, email, \`user\`.name, last_name, address, phone, \`role\`.description role, \`city\`.description city 
             FROM \`user\` 
             JOIN \`role\` ON \`user\`.id_role=\`role\`.id_role 
             JOIN \`city\` ON \`user\`.id_city=\`city\`.id_city`,
            [],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    },
    createUser: (data, callBack) => {
        pool.query(
            `INSERT INTO \`user\` VALUES (null, ?, ?, null, ?, ?, ?, ?, ?, ?, ?);`,
            [   data.username,
                data.password,
                data.email,
                data.name,
                data.last_name,
                data.address,
                data.phone,
                data.id_role,
                data.id_city    ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    }
};