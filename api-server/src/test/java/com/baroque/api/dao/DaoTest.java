package com.baroque.api.dao;

import com.baroque.api.TestSupport;
import com.baroque.api.entity.DishEntity;
import com.baroque.api.enums.TastyType;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

/**
 * @author elric.wang
 */
public class DaoTest extends TestSupport {
    @Autowired
    private DishDao dishDao;

    @Autowired
    private OrderDao orderDao;

    @Test
    public void dishDaoShouldReturnAllDishesWhenQueryAll() {
        List<DishEntity> dishEntities = dishDao.findAllDishes();
        assertNotNull(dishEntities);
        assertTrue(!dishEntities.isEmpty());
    }

    @Test
    public void orderDaoShouldInsertOneOrderWhenAddOrder() {
        int id = orderDao.addOrder(2, 4);
        assertTrue(id > 1);
    }

    @Test
    public void orderDaoShouldInsertMultiOrderItemWhenAddOrderItem() {
        orderDao.addOrderItems(2, new int[] {1, 2}, new int[] {1, 1}, new int[] {TastyType.超级辣.value, TastyType.甜.value});
    }
}
