package com.baroque.api.web;

import com.baroque.api.entity.DishEntity;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author elric.wang
 */
public class MenuListServlet extends BaseServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> result = new HashMap<String, Object>();
        DishEntity dishEntity = new DishEntity();
        dishEntity.setFoodId(1);
        dishEntity.setFoodName("酸菜鱼");
        dishEntity.setPrice(25f);
        dishEntity.setFoodType("菜");
        dishEntity.setTastyType("辣");
        dishEntity.setPicUrl("http://baroque-img.stor.sinaapp.com/1_small.jpg");
        JSONArray body = new JSONArray();
        body.put(new JSONObject(dishEntity));
        dishEntity = new DishEntity();
        dishEntity.setFoodId(2);
        dishEntity.setFoodName("红烧肉");
        dishEntity.setPrice(25f);
        dishEntity.setFoodType("菜");
        dishEntity.setTastyType("不辣");
        dishEntity.setPicUrl("http://baroque-img.stor.sinaapp.com/2_small.jpg");
        body.put(new JSONObject(dishEntity));
        result.put("code", 200);
        result.put("body", body);
        JSONObject o = new JSONObject(result);
        resp.setCharacterEncoding("utf-8");
        resp.getWriter().println(o.toString());
    }
}
