package com.baroque.api.web.api;

import com.baroque.api.dao.OrderDao;
import com.baroque.api.entity.OrderEntity;
import com.baroque.api.entity.OrderItemEntity;
import com.baroque.api.web.BaseExecutor;
import org.apache.commons.beanutils.BeanUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @author elric.wang
 */
public class ViewOrderApi extends BaseExecutor {

    private OrderDao orderDao;

    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    @Override
    public void execute() throws Exception {
        Integer orderId = new Integer(request.getParameter("orderId"));
        if (orderId == null) {
            code = 500;
            msg = "invalid order id";
            return;
        }
        OrderEntity order = orderDao.loadOrderById(orderId);
        if (order == null) {
            code = 500;
            msg = String.format("order [id=%d] not exist", orderId);
            return;
        }
        List<OrderItemEntity> orderItems = orderDao.findOrderItemsByOrderID(orderId);
        order.setOrderItems(orderItems);
        code = 200;
        body = order;
    }
}
