const service = require("./order.service");

module.exports = {
    getAll: (req, res) => {
        service.getAllOrders((err, results) => {
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
    create: (req, res) => {
        service.createOrder(req.body, (err, results) => {
            if (err) {
                return res.status(500).json({
                    success: 0,
                    message: "Error creating order."
                })
            }
            const id_order = results.insertId;
            const details = req.body.details;
            details.forEach(element => {
                const { id_product, quantity } = element;
                service.getPrice(id_product, (err, price) => {
                    if (err) {
                        return res.status(500).json({
                            success: 0,
                            message: "Error searching for price."
                        });    
                    }
                    service.addDetail(id_order, id_product, quantity, price, (err, results) => {
                        if (err) {
                            return res.status(500).json({
                                success: 0,
                                message: "Error adding details."
                            })
                        }
                    });
                });
            });
            return res.status(200).json({
                success: 1,
                data: results
            })
        });
    },
    updateStatus: (req, res) => {
        const body = req.body;
        const id_order = body.id_order;
        const id_state = body.id_state;
        service.updateOrderStatus(id_order, id_state, (err, results) => {
            if (err) {
                return res.status(500).json({
                    success: 0,
                    message: "Error updating status"
                })
            }
            return res.status(200).json({
                success: 1,
                data: results
            })
        })
    }
}