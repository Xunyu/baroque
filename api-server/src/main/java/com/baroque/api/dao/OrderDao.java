package com.baroque.api.dao;

import com.baroque.api.entity.OrderEntity;
import com.baroque.api.entity.OrderItemEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * @author elric.wang
 */
public class OrderDao {
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<OrderEntity> findAllOrders() {
        String sql = "select OrderID, TableID, CustomerCount from Bar_Order";
        return jdbcTemplate.query(sql, new OrderRowMapper());
    }

    public List<OrderItemEntity> findOrderItemsByOrderID(int orderId) {
        final String sql = "select * from Bar_OrderItem where OrderID = ?";
        return jdbcTemplate.query(sql, new Object[] {orderId}, new OrderItemRowMapper());
    }

    private class OrderRowMapper implements RowMapper {

        @Override
        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
            OrderEntity orderEntity = new OrderEntity();
            orderEntity.setOrderId(rs.getInt("OrderID"));
            orderEntity.setDeskId(rs.getInt("TableID"));
            orderEntity.setCustomerCount(rs.getInt("CustomerCount"));
            return orderEntity;
        }
    }

    private class OrderItemRowMapper implements RowMapper {
        @Override
        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
            OrderItemEntity orderItemEntity = new OrderItemEntity();
            orderItemEntity.setFoodId(rs.getInt("FoodID"));
            return orderItemEntity;
        }
    }
}
