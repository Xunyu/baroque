package com.baroque.api.enums;

/**
 * @author elric.wang
 */
public enum FoodType {
    菜(1),
    主食(2),
    酒水(3);

    public final int value;

    private FoodType(int value) {
        this.value = value;
    }

    public static String toString(int value) {
        FoodType foodType = parseInt(value);
        if (foodType == null) {
            return null;
        }
        return foodType.toString();
    }

    private static FoodType parseInt(int value) {
        for (FoodType e : FoodType.values()) {
            if (e.value == value) {
                return e;
            }
        }
        return null;
    }
}
