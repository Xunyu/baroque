package com.baroque.api.dao;

import com.baroque.api.entity.OrderEntity;
import com.baroque.api.entity.OrderItemEntity;
import com.baroque.api.enums.TastyType;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;

import java.sql.*;
import java.util.ArrayList;
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
        String sql = "select * from Bar_Order";
        return jdbcTemplate.query(sql, new OrderRowMapper());
    }

    public List<OrderItemEntity> findOrderItemsByOrderID(int orderId) {
        final String sql = "select *, m.FoodName from Bar_OrderItem oi left join Bar_Menu m on oi.FoodID = m.FoodID where OrderID = ?";
        return jdbcTemplate.query(sql, new Object[] {orderId}, new OrderItemRowMapper());
    }

    public OrderEntity loadOrderById(int orderId) {
        final String sql = "select * from Bar_Order where OrderID = ?";
        List<OrderEntity> orders = jdbcTemplate.query(sql, new Object[] { orderId }, new OrderRowMapper());
        if (!CollectionUtils.isEmpty(orders)) {
            return orders.get(0);
        }
        return null;
    }

    public int addOrder(final int tableId, final int customerCount) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                final String sql = String.format("insert into Bar_Order (TableID, CustomerCount, AddTime) values (%d, %d, NOW())", tableId, customerCount);
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                return ps;
            }
        }, keyHolder);
        return keyHolder.getKey().intValue();
    }

    public void addOrderItems(int orderId, int[] dishIds, int[] dishCount, int[] tastys) {
        String sql = "insert into Bar_OrderItem (OrderID, FoodID, Count, Cooking, Tasty) values (%d, %d, %d, %d, %d)";
        List<String> sqls = new ArrayList<String>();
        for (int i = 0; i < dishIds.length; i++) {
            int dishId = dishIds[i];
            int count = dishCount[i];
            int tasty = tastys[i];
            sqls.add(String.format(sql, orderId, dishId, count, 0, tasty));
        }
        jdbcTemplate.batchUpdate(sqls.toArray(new String[]{}));
    }

    private class OrderRowMapper implements RowMapper {

        @Override
        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
            OrderEntity orderEntity = new OrderEntity();
            orderEntity.setOrderId(rs.getInt("OrderID"));
            orderEntity.setTableId(rs.getInt("TableID"));
            orderEntity.setCustomerCount(rs.getInt("CustomerCount"));
            orderEntity.setAddTime(rs.getTimestamp("AddTime"));
            return orderEntity;
        }
    }

    private class OrderItemRowMapper implements RowMapper {
        @Override
        public Object mapRow(ResultSet rs, int rowNum) throws SQLException {
            OrderItemEntity orderItemEntity = new OrderItemEntity();
            orderItemEntity.setFoodId(rs.getInt("FoodID"));
            orderItemEntity.setCount(rs.getInt("Count"));
            orderItemEntity.setTasty(TastyType.toString(rs.getInt("Tasty")));
            orderItemEntity.setFoodName(rs.getString("FoodName"));
            return orderItemEntity;
        }
    }
}
