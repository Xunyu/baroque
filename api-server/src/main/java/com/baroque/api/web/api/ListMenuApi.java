package com.baroque.api.web.api;

import com.baroque.api.entity.DishEntity;
import com.baroque.api.web.BaseExecutor;

import java.util.ArrayList;
import java.util.List;

/**
 * @author elric.wang
 */
public class ListMenuApi extends BaseExecutor {

    @Override
    public void execute() {
        List<DishEntity> dishes = new ArrayList<DishEntity>();
        DishEntity dishEntity = new DishEntity();
        dishEntity.setFoodId(1);
        dishEntity.setFoodName("酸菜鱼");
        dishEntity.setPrice(25f);
        dishEntity.setFoodType("菜");
        dishEntity.setTastyType("辣");
        dishEntity.setPicUrl("http://baroque-img.stor.sinaapp.com/1_small.jpg");
        dishes.add(dishEntity);
        dishEntity = new DishEntity();
        dishEntity.setFoodId(2);
        dishEntity.setFoodName("红烧肉");
        dishEntity.setPrice(25f);
        dishEntity.setFoodType("菜");
        dishEntity.setTastyType("不辣");
        dishEntity.setPicUrl("http://baroque-img.stor.sinaapp.com/2_small.jpg");
        dishes.add(dishEntity);
        code = 200;
        body = dishes;
    }
}
