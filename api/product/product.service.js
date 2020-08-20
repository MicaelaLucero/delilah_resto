const pool = require("../../config/database");

module.exports = {
    getByID: (data, callBack) => {
        pool.query(
            `SELECT * FROM product WHERE id_product = ?`,
            [   data.id_product ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        )
    },
    getAll: callBack => {
        pool.query(
            `SELECT id_product, description, price FROM \`product\``, [],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        )
    },
    create: (data, callBack) => {
        pool.query(
            `INSERT INTO product VALUES(null, ?, ?)`,
            [   data.description,
                data.price  ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    },
    update: (data, callBack) => {
        pool.query(
            `UPDATE product SET description = ?, price = ? WHERE id_product = ?`,
            [   data.description,
                data.price,
                data.id_product ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        )
    },
    delete: (data, callBack) => {
        pool.query(
            `DELETE FROM product WHERE id_product = ?`,
            [   data.id_product ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        )
    }
};