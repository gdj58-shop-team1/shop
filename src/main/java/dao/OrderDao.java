package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Orders;

public class OrderDao {
	
	// 주문입력(goodsOne -> 바로 구매)
	public int insertOrderDirect(Connection conn, Orders paramOrder) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO orders (goods_option, goods_code, customer_id, address_code, order_quantity, order_price, order_state)"
				+ " VALUES(?, ?, ?, ?, ?, ?, '주문완료')";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramOrder.getGoodsOption());
		stmt.setInt(2, paramOrder.getGoodsCode());
		stmt.setString(3, paramOrder.getCustomerId());
		stmt.setInt(4, paramOrder.getAddressCode());
		stmt.setInt(5, paramOrder.getOrderQuantity());
		stmt.setInt(6, paramOrder.getOrderPrice());
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;
	}
	
	// 주문입력(cart -> 구매)
		public HashMap<String, Integer> insertOrderFromCart(Connection conn, Orders orders) throws Exception{
			int row = 0;
			int autoKey = 0;
			String sql = "INSERT INTO orders (goods_option, goods_code, customer_id, address_code, order_quantity, order_price, order_state)"
					+ " VALUES(?, ?, ?, ?, ?, ?, '주문완료')";
			
			PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, orders.getGoodsOption());
			stmt.setInt(2, orders.getGoodsCode());
			stmt.setString(3, orders.getCustomerId());
			stmt.setInt(4, orders.getAddressCode());
			stmt.setInt(5, orders.getOrderQuantity());
			stmt.setInt(6, orders.getOrderPrice());
			
			row = stmt.executeUpdate();
			
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				autoKey = rs.getInt(1); // stmt.executeUpdate(); 생성된 auto_increment값이 대입
			}
			
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("row", row);
			map.put("autoKey", autoKey);
			
			stmt.close();
			return map;
		}
	
	// 포인트 처리 위한 주문코드 출력
	public int selectRecentOrder(Connection conn, String customerId) throws Exception{
		int orderCode = 0;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT order_code orderCode FROM orders WHERE customer_id = ? ORDER BY createdate DESC";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		rs = stmt.executeQuery();
		if(rs.next()) {
			orderCode = rs.getInt("orderCode");
		}
		
		rs.close();
		stmt.close();
		return orderCode;
	}
	
	// 회원
	// 주문목록 출력(select) : 본인이 주문한 주문목록에 한해서
	public ArrayList<HashMap<String, Object>> selectOrderListById(Connection conn, String customerId) throws Exception{
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT "
				+ "o.order_code orderCode"
				+ ", g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", g.goods_price goodsPrice"
				+ ", o.goods_option goodsOption"
				+ ", o.order_quantity orderQuantity"
				+ ", o.order_price orderPrice"
				+ ", o.order_state orderState"
				+ ", o.createdate createdate"
				+ ", r.review_memo reviewMemo"
				+ " FROM orders o INNER JOIN goods g"
				+ "	 ON o.goods_code = g.goods_code"
				+ "	 LEFT OUTER JOIN review r ON r.order_code = o.order_code"
				+ " WHERE o.customer_id = ?"
				+ " ORDER BY o.order_code DESC;";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("goodsName", rs.getString("goodsName"));
			map.put("goodsOption", rs.getString("goodsOption"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("orderQuantity", rs.getInt("orderQuantity"));
			map.put("orderPrice", rs.getInt("orderPrice"));
			map.put("orderState", rs.getString("orderState"));
			map.put("createdate", rs.getString("createdate"));
			map.put("reviewMemo", rs.getString("reviewMemo"));
			orderList.add(map);
		}
		
		// int size = orderList.size();
		// System.out.println("size: "+size);
		
		rs.close();
		stmt.close();
		return orderList;
	}
	
	// 특정 주문 출력(select) : 리뷰 또는 상품 문의글 작성시 필요한 정보 출력
	public HashMap<String, Object> selectOrderByOrderCode(Connection conn, int orderCode) throws Exception{
		HashMap<String, Object> order = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ "	o.order_code orderCode"
				+ "	, g.goods_code goodsCode"
				+ "	, g.goods_name goodsName"
				+ "	, g.goods_price goodsPrice"
				+ "	, o.order_quantity orderQuantity" 	// 필요 없을 시 삭제
				+ "	, o.order_price orderPrice"
				+ "	, o.customer_id customerId" 		// 필요 없을 시 삭제
				+ "	, o.order_state orderState" 		// 필요 없을 시 삭제
				+ "	, o.createdate createdate"
				+ " FROM orders o INNER JOIN goods g"
				+ "  ON o.goods_code = g.goods_code"
				+ " WHERE o.order_code = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderCode);
		rs = stmt.executeQuery();
		if(rs.next()) {
			order = new HashMap<String, Object>();
			order.put("orderCode", rs.getInt("orderCode"));
			order.put("orderPrice", rs.getInt("orderPrice"));
			order.put("goodsPrice", rs.getInt("goodsPrice"));
			order.put("goodsName", rs.getString("goodsName"));
			order.put("createdate", rs.getString("createdate"));
		}
		
		rs.close();
		stmt.close();
		return order;
	}
	
	// 관리자
	// 모든 주문목록 출력(select) : 모든 주문목록 출력
	public ArrayList<HashMap<String, Object>> selectOrderListAll(Connection conn) throws Exception{
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ "	o.order_code orderCode"
				+ " , g.goods_code goodsCode"
				+ "	, g.goods_name goodsName"
				+ "	, g.goods_price goodsPrice"
				+ " , o.goods_option goodsOption"
				+ "	, o.order_quantity orderQuantity"
				+ "	, o.order_price orderPrice"
				+ "	, o.customer_id customerId"
				+ "	, o.order_state orderState"
				+ "	, o.createdate createdate"
				+ " FROM orders o INNER JOIN goods g"
				+ "	 ON o.goods_code = g.goods_code"
				+ " ORDER BY o.order_code desc;";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("goodsName", rs.getString("goodsName"));
			map.put("goodsOption", rs.getString("goodsOption"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("orderQuantity", rs.getInt("orderQuantity"));
			map.put("orderPrice", rs.getInt("orderPrice"));
			map.put("customerId", rs.getString("customerId"));
			map.put("orderState", rs.getString("orderState"));
			map.put("createdate", rs.getString("createdate"));
			orderList.add(map);
		}
		
		rs.close();
		stmt.close();
		return orderList;
	}
	
	// 주문상태 수정(update : orderList)
	public int updateOrder(Connection conn, int orderCode, String orderState) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE orders SET order_state = ? WHERE order_code = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, orderState);
		stmt.setInt(2, orderCode);
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;
	}
	 
}
