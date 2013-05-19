package com.baroque.api.dao;

import com.baroque.api.entity.DishEntity;
import com.baroque.api.enums.FoodType;
import com.baroque.api.enums.TastyType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * @author elric.wang
 */
public class DishDao {

    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public int selectOne() {
        return  jdbcTemplate.queryForInt("select 1");
    }

    public List<DishEntity> findAllDishes() {
        final String sql = "select FoodID, FoodName, PicUrl, Price, FoodType, TastyType from Bar_Menu";
        return jdbcTemplate.query(sql, new DishRowMapper());
    }

    private final class DishRowMapper implements RowMapper {

        @Override
        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
            DishEntity dishEntity = new DishEntity();
            dishEntity.setFoodId(rs.getInt("FoodID"));
            dishEntity.setFoodName(rs.getString("FoodName"));
            dishEntity.setPicUrl(rs.getString("PicUrl"));
            dishEntity.setPrice(rs.getFloat("Price"));
            dishEntity.setFoodType(FoodType.toString(rs.getInt("FoodType")));
            dishEntity.setTastyType(TastyType.toString(rs.getInt("TastyType")));
            return dishEntity;
        }
    }
}
