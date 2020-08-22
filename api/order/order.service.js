const pool = require("../../config/database");

module.exports = {
    getPrice: (id_product, callBack) => {
        pool.query(
            `SELECT id_product, price FROM product WHERE id_product = ?`,
            [ id_product ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results[0].price);
            }
        )
    },
    getAllOrders: (callBack) => {
        pool.query(
            `SELECT ord.id_order, ord.time, st.description, pay.description, u.username, u.address 
             FROM \`orders\` ord 
             JOIN order_state st ON ord.id_state = st.id_state 
             JOIN payment pay ON ord.id_payment = pay.id_payment 
             JOIN user u ON ord.id_user = u.id_user ORDER BY ord.time`, [],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    },
    createOrder: (data, callBack) => {
        pool.query(
            `INSERT INTO \`orders\` VALUES(default, ?, ?, default, 1)`,
            [
                data.id_user,
                data.id_payment
            ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    },
    getOrderById: (data, callBack) => {
        pool.query(
            `SELECT * FROM \`orders\` WHERE id_order = ?`,
            [ data.id_order ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        )
    },
    deleteOrder: (data, callBack) => {
        pool.query(
            `DELETE FROM \`orders\` WHERE id_order = ?`,
            [ data.id_order ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    },
    deleteOrderDetail: (data, callBack) => {
        pool.query(
            `DELETE FROM \`order_detail\` WHERE id_order = ?`,
            [ data.id_order ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    },
    addDetail: (id_order, id_product, quantity, price, callBack) => {
        pool.query(
            `INSERT INTO \`order_detail\` VALUES(null, ?, ?, ?, ?)`,
            [   id_product,
                quantity,
                price * quantity,
                id_order ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        );
    },
    updateOrderStatus: (id_order, id_state, callBack) => {
        pool.query(
            `UPDATE \`orders\` SET id_state = ? WHERE id_order = ?`,
            [   id_state,
                id_order    ],
            (error, results, fields) => {
                if (error) {
                    return callBack(error);
                }
                return callBack(null, results);
            }
        )
    },
};