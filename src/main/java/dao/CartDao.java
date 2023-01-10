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
				+ " cart(goods_code, customer_id, cart_quantity)";

		PreparedStatement stmt = conn.prepareStatement(sql);
		
		row = stmt.executeUpdate();
		
		stmt.close();
		
		return row;
	}
	
	// 2) 장바구니에 있던 물품 수량 변경
	public int updateCart(Connection conn, Cart cart) throws Exception {
		int row = 0;
		
		String sql = "UPDATE cart"
				+ " SET cart_quantity = ?"
				+ " WHERE goods_code = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cart.getCartQuantity());
		stmt.setInt(2, cart.getGoodsCode());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		
		return row;
	}
	
	// 3) 장바구니 속 물품 지우기(1개)
	public int deleteCartOne(Connection conn, Cart cart) throws Exception {
		int row = 0;
		
		String sql = "DELETE"
				+ " FROM cart"
				+ " WHERE customer_id = ? AND goods_code = ?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cart.getCustomerId());
		stmt.setString(2, cart.getCustomerId());
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 4) 장바구니 속 물품 지우기(모든)
	public int deleteCartAll(Connection conn, Cart cart) throws Exception {
		int row = 0;
		
		String sql = "DELETE"
				+ " FROM cart"
				+ " WHERE customer_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cart.getCustomerId());
		row = stmt.executeUpdate();
		
		stmt.close();
		
		return row;
	}
	
	// 5) 장바구니 조회
	public ArrayList<HashMap<String, Object>> selectCartList(Connection conn, Customer customer) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		String sql = "SELECT img.filename fileName"
				+ " g.goods_name goodsName"
				+ " c.cart_quantity cartQuantity"
				+ " FROM cart c"
				+ "	INNER JOIN goods g"
				+ " ON c.goods_code = g.goods_code"
				+ " INNER JOIN goods_img img"
				+ " ON g.goods_code = img.goods_code"
				+ " WHERE c.customer_id = ?"
				+ " ORDER BY c.createdate";
		
		PreparedStatement stmt = conn.prepareStatement(sql);	
		stmt.setString(1, customer.getCustomerId());
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("fileName", rs.getString("fileName"));
			map.put("goodsName", rs.getString("goodsName"));
			map.put("cartQuantity", rs.getInt("cartQuantity"));
			list.add(map);
		}
		
		rs.close();
		stmt.close();
		
		return list;
	}
	
	// 6) 장바구니속 물건인지 확인
	public int selectCart(Connection conn, Cart cart) throws Exception {
		int row = 0;
		
		String sql = "SELECT goods_code"
				+ " FROM card"
				+ " WHERE goods_code = ? AND Customer_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);	
		stmt.setString(1, cart.getCustomerId());
		
		ResultSet rs = stmt.executeQuery();
		
		row = rs.getRow();
		
		rs.close();
		stmt.close();
		return row;
		
	}
}
