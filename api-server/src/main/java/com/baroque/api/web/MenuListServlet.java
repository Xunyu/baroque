package com.baroque.api.web;

import com.baroque.api.entity.DishEntity;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: elric
 * Date: 13-5-10
 * Time: 下午2:14
 * To change this template use File | Settings | File Templates.
 */
public class MenuListServlet extends BaseServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> result = new HashMap<String, Object>();
        DishEntity dishEntity = new DishEntity();
        dishEntity.setFoodId(1);
        dishEntity.setFoodName("水煮鱼");
        dishEntity.setPrice(25f);
        dishEntity.setFoodType("菜");
        dishEntity.setTastyType("辣");
        dishEntity.setPicUrl("http://s1.baroque.com/1235.jpg");
        result.put("code", 200);
        ArrayList<DishEntity> dishs = new ArrayList<DishEntity>();
        dishs.add(dishEntity);
        result.put("body", dishs);
        JSONObject o = new JSONObject(result);
        resp.getWriter().println(o.toString());
    }
}
