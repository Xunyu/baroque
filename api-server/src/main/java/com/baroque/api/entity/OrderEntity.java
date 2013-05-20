package com.baroque.api.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author elric.wang
 */
public class OrderEntity implements Serializable {

    private static final long serialVersionUID = 2355581124437071402L;

    private int orderId;

    private int tableId;

    private int customerCount;

    private Date addTime;

    private List<OrderItemEntity> orderItems;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
    }

    public int getCustomerCount() {
        return customerCount;
    }

    public void setCustomerCount(int customerCount) {
        this.customerCount = customerCount;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public List<OrderItemEntity> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItemEntity> orderItems) {
        this.orderItems = orderItems;
    }
}
