package com.baroque.api.web.api;

import com.baroque.api.entity.OrderEntity;
import com.baroque.api.web.BaseExecutor;

import java.util.ArrayList;
import java.util.List;

/**
 * @author elric.wang
 */
public class ListOrdersApi extends BaseExecutor {

    @Override
    public void execute() {
        List<OrderEntity> orders = new ArrayList<OrderEntity>();
        OrderEntity order = new OrderEntity();
        order.setOrderId(1);
        order.setDeskId(4);
        order.setCustomerCount(5);
        orders.add(order);

        order = new OrderEntity();
        order.setOrderId(2);
        order.setDeskId(3);
        order.setCustomerCount(2);
        orders.add(order);

        code = 200;
        body = orders;
    }
}
