package com.baroque.api.web.api;

import com.baroque.api.entity.OrderEntity;
import com.baroque.api.entity.OrderItemEntity;
import com.baroque.api.web.BaseExecutor;

import java.util.ArrayList;
import java.util.List;

/**
 * @author elric.wang
 */
public class ViewOrderApi extends BaseExecutor {

    @Override
    public void execute() {
        Integer orderId = null;
        try {
            orderId = new Integer(request.getParameter("orderId"));
        } catch (Exception e) {
        }
        if (orderId == null) {
            code = 500;
            msg = "invalid order id";
            return;
        }
        OrderEntity order = new OrderEntity();
        order.setOrderId(orderId);
        order.setDeskId(3);
        order.setCustomerCount(2);
        List<OrderItemEntity> orderItems = new ArrayList<OrderItemEntity>();
        order.setOrderItems(orderItems);

        OrderItemEntity orderItem = new OrderItemEntity();
        orderItem.setFoodId(1);
        orderItem.setFoodName("水煮鱼");
        orderItem.setCount(1);
        orderItem.setTasty("微辣");
        orderItems.add(orderItem);

        orderItem.setFoodId(3);
        orderItem.setFoodName("肉夹馍");
        orderItem.setCount(3);
        orderItems.add(orderItem);

        code = 200;
        body = order;
    }
}
