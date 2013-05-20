package com.baroque.api.entity;

import java.io.Serializable;
import java.util.List;

/**
 * @author elric.wang
 */
public class OrderEntity implements Serializable {

    private static final long serialVersionUID = 2355581124437071402L;

    private int orderId;

    private int deskId;

    private int customerCount;

    private List<OrderItemEntity> orderItems;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getDeskId() {
        return deskId;
    }

    public void setDeskId(int deskId) {
        this.deskId = deskId;
    }

    public int getCustomerCount() {
        return customerCount;
    }

    public void setCustomerCount(int customerCount) {
        this.customerCount = customerCount;
    }

    public List<OrderItemEntity> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItemEntity> orderItems) {
        this.orderItems = orderItems;
    }
}
