package com.baroque.api.web.api;

import com.baroque.api.dao.OrderDao;
import com.baroque.api.web.BaseExecutor;

import java.util.HashMap;
import java.util.Map;

/**
 * @author elric.wang
 */
public class CommitOrderApi extends BaseExecutor {

    private OrderDao orderDao;

    public void setOrderDao(OrderDao orderDao) {
        this.orderDao = orderDao;
    }

    @Override
    public void execute() throws Exception {
        int tableId = Integer.parseInt(request.getParameter("tableId"));
        int customerCount = Integer.parseInt(request.getParameter("customerCount"));
        String[] dishIds = request.getParameterValues("foodId");
        String[] dishCount = request.getParameterValues("count");
        String[] tastys = request.getParameterValues("tasty");

        int orderId = orderDao.addOrder(tableId, customerCount);
        orderDao.addOrderItems(orderId, convertBatch(dishIds), convertBatch(dishCount), convertBatch(tastys));
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("orderId", orderId);
        code = 200;
        msg = "success";
        body = result;
    }

    private int[] convertBatch(String[] strings) {
        int[] integers = new int[strings.length];
        for (int i = 0; i < strings.length; i++) {
            integers[i] = Integer.parseInt(strings[i]);
        }
        return integers;
    }
}
