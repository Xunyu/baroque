package com.baroque.api.dao;

import com.baroque.api.entity.DishEntity;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

/**
 * @author elric.wang
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
        "classpath*:config/spring/appcontext-*.xml"
})
public class DishDaoTest {
    @Autowired
    private DishDao dishDao;

    @Test
    public void dishDaoShouldReturn1WhenSelectOne() {
        int one = dishDao.selectOne();
        assertEquals(1, one);
    }

    @Test
    public void dishDaoShouldReturnAllDishesWhenQueryAll() {
        List<DishEntity> dishEntities = dishDao.findAllDishes();
        assertNotNull(dishEntities);
        assertTrue(!dishEntities.isEmpty());
    }
}
