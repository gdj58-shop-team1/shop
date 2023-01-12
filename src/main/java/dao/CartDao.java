package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Cart;
import vo.Customer;

public class CartDao {
	// 1) 장바구니에 없던 물품 추가
	public int insesrtCart(Connection conn, Cart cart) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO"
				+ " cart(goods_code, customer_id, goods_option, cart_quantity)"
				+ " VALUES(?, ?, ?, ?)";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getGoodsCode());
		stmt.setString(2, cart.getCustomerId());
		stmt.setString(3, cart.getGoodsOption());
		stmt.setInt(4, cart.getCartQuantity());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		
		return row;
	}
	
	// 2) 장바구니에 있던 물품 수량변경
	public int updateCart(Connection conn, Cart cart) throws Exception {
		int row = 0;
		
		String sql = "UPDATE cart"
				+ " SET cart_quantity = cart_quantity + ?"
				+ " WHERE goods_code = ? AND customer_id = ? AND goods_option = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getCartQuantity());
		stmt.setInt(2, cart.getGoodsCode());
		stmt.setString(3, cart.getCustomerId());
		stmt.setString(4, cart.getGoodsOption());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		
		return row;
	}
	
	// 3) 장바구니 속 물품 지우기(1개)
	public int deleteCartOne(Connection conn, Cart cart) throws Exception {
		int row = 0;
		
		String sql = "DELETE"
				+ " FROM cart"
				+ " WHERE goods_code = ? AND customer_id = ? AND goods_option = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getGoodsCode());
		stmt.setString(2, cart.getCustomerId());
		stmt.setString(3, cart.getGoodsOption());
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 4) 장바구니 속 물품 지우기(모든)
	public int deleteCartAll(Connection conn, Customer customer) throws Exception {
		int row = 0;
		
		String sql = "DELETE"
				+ " FROM cart"
				+ " WHERE customer_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		
		return row;
	}
	
	// 5) 장바구니 조회
	public ArrayList<HashMap<String, Object>> selectCartList(Connection conn, Customer customer) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		System.out.println(customer.getCustomerId()+"아아");
		String sql = "SELECT img.filename fileName\r\n"
				+ "				, g.goods_code goodsCode\r\n"
				+ "				, g.goods_name goodsName\r\n"
				+ "				, g.goods_price goodsPrice\r\n"
				+ "				, c.goods_option goodsOption\r\n"
				+ "				, c.cart_quantity cartQuantity\r\n"
				+ "				 FROM cart c\r\n"
				+ "					INNER JOIN goods g\r\n"
				+ "				 ON c.goods_code = g.goods_code\r\n"
				+ "				 INNER JOIN goods_img img\r\n"
				+ "				 ON g.goods_code = img.goods_code\r\n"
				+ "				 WHERE c.customer_id = ?\r\n"
				+ "				 ORDER BY c.createdate";
		
		PreparedStatement stmt = conn.prepareStatement(sql);	
		stmt.setString(1, customer.getCustomerId());
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("fileName", rs.getString("fileName"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("goodsName", rs.getString("goodsName"));
			map.put("goodsPrice", rs.getInt("goodsPrice"));
			map.put("goodsOption", rs.getString("goodsOption"));
			map.put("orderQuantity", rs.getInt("cartQuantity"));
			list.add(map);
		}
		
		rs.close();
		stmt.close();		
		return list;
	}
	
	// 6) 장바구니속 물건인지 확인
	public boolean selectCart(Connection conn, Cart cart) throws Exception {
		boolean flag = false;
		
		String sql = "SELECT goods_code, customer_id, goods_option"
				+ " FROM cart"
				+ " WHERE goods_code = ? AND customer_id = ? AND goods_option = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getGoodsCode());
		stmt.setString(2, cart.getCustomerId());	
		stmt.setString(3, cart.getGoodsOption());
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			flag = true;
		}
		
		rs.close();
		stmt.close();
		return flag;
		
	}
}
