package com.baroque.api.web.api;

import com.baroque.api.dao.DishDao;
import com.baroque.api.entity.DishEntity;
import com.baroque.api.web.BaseExecutor;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * @author elric.wang
 */
public class ListMenuApi extends BaseExecutor {


    private DishDao dishDao;

    public void setDishDao(DishDao dishDao) {
        this.dishDao = dishDao;
    }

    @Override
    public void execute() {
        List<DishEntity> dishes = dishDao.findAllDishes();
        code = 200;
        body = dishes;
    }
}
