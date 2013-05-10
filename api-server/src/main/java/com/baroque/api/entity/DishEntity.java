package com.baroque.api.entity;

import java.io.Serializable;

public class DishEntity implements Serializable {

    private int foodId;

    private String foodName;

    private float price;

    private String tastyType;

    private String foodType;

    private String picUrl;

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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getTastyType() {
        return tastyType;
    }

    public void setTastyType(String tastyType) {
        this.tastyType = tastyType;
    }

    public String getFoodType() {
        return foodType;
    }

    public void setFoodType(String foodType) {
        this.foodType = foodType;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }
}
