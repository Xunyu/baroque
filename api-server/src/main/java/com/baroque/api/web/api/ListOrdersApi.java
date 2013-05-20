package com.baroque.api.web.api;

import com.baroque.api.dao.OrderDao;
import com.baroque.api.entity.OrderEntity;
import com.baroque.api.web.BaseExecutor;

import java.util.ArrayList;
import java.util.List;

/**
 * @author elric.wang
 */
public class ListOrdersApi extends BaseExecutor {

    private OrderDao orderDao;

    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    @Override
    public void execute() throws Exception {
        List<OrderEntity> orders = orderDao.findAllOrders();
        code = 200;
        body = orders;
    }
}
