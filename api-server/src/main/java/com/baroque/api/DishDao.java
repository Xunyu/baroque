package com.baroque.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * @author elric.wang
 */
public class DishDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;


}
