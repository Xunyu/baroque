package com.baroque.api.entity;

import org.json.JSONObject;

import java.io.Serializable;

/**
 * @author elric.wang
 */
public class OrderItemEntity implements Serializable {

    private static final long serialVersionUID = 6123059807525425933L;

    private int foodId;

    private String foodName;

    private int count;

    private String tasty;

    private String cooking;

    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getTasty() {
        return tasty;
    }

    public void setTasty(String tasty) {
        this.tasty = tasty;
    }

    public String getCooking() {
        return cooking;
    }

    public void setCooking(String cooking) {
        this.cooking = cooking;
    }

}
