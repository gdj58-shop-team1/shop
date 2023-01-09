package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class OrderDao {
	
	// 회원
	// 주문목록 출력(select) : 본인이 주문한 주문목록에 한해서
	public ArrayList<HashMap<String, Object>> selectOrderListById(Connection conn, String customerId) throws Exception{
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ "	o.order_code orderCode"
				+ "	, concat( g.goods_category, ' - ', g.goods_name) goods" // goodsName? goods?
				+ "	, g.goods_price goodsPrice"
				+ "	, o.order_quantity orderQuantity"
				+ "	, o.order_price orderPrice"
				+ "	, o.order_state goodsState"
				+ "	, o.createdate createdate"
				+ " FROM orders o INNER JOIN goods g"
				+ "	 ON o.goods_code = g.goods_code"
				+ " WHERE o.customer_id = ?"
				+ " ORDER BY o.order_code DESC;";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goods", rs.getString("goods"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("orderQuantity", rs.getInt("orderQuantity"));
			map.put("orderPrice", rs.getInt("orderPrice"));
			map.put("goodsState", rs.getString("goodsState"));
			map.put("createdate", rs.getString("createdate"));
			orderList.add(map);
		}
		
		rs.close();
		stmt.close();
		return orderList;
	}
	
	// 관리자
	// 모든 주문목록 출력(select) : 모든 주문목록 출력
	public ArrayList<HashMap<String, Object>> selectOrderListAll(Connection conn) throws Exception{
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ "	o.order_code orderCode"
				+ "	, concat( g.goods_category, ' - ', g.goods_name) goods" 
				+ "	, g.goods_price goodsPrice"
				+ "	, o.order_quantity orderQuantity"
				+ "	, o.order_price orderPrice"
				+ "	, o.customer_id cutomerId"
				+ "	, o.order_state goodsState"
				+ "	, o.createdate createdate"
				+ " FROM orders o INNER JOIN goods g"
				+ "	 ON o.goods_code = g.goods_code"
				+ " ORDER BY o.order_code desc;";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goods", rs.getString("goods"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("orderQuantity", rs.getInt("orderQuantity"));
			map.put("orderPrice", rs.getInt("orderPrice"));
			map.put("cutomerId", rs.getString("cutomerId"));
			map.put("goodsState", rs.getString("goodsState"));
			map.put("createdate", rs.getString("createdate"));
			orderList.add(map);
		}
		
		rs.close();
		stmt.close();
		return orderList;
	}
	
	// 주문상태 수정
	 
}
