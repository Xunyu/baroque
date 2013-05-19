package com.baroque.api.enums;

/**
 * @author elric.wang
 */
public enum TastyType {
    甜(1),
    酸(2),
    辣(3),
    超级辣(4),
    主厨推荐(5);

    public final int value;

    private TastyType(int value) {
        this.value = value;
    }


    public static String toString(int value) {
        TastyType tastyType = parseInt(value);
        if (tastyType == null) {
            return null;
        }
        return tastyType.toString();
    }

    private static TastyType parseInt(int value) {
        for (TastyType e : TastyType.values()) {
            if (e.value == value) {
                return e;
            }
        }
        return null;
    }
}
