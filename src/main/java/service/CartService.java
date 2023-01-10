package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dao.CartDao;
import util.DBUtil;
import vo.Customer;

public class CartService {
	private CartDao cartDao;
	private DBUtil dbUtil;
	
	// 1) 장바구니 없던 물품 추가
	
	// 2) 장바구니에 있던 물품 수량 변경
	
	// 3) 장바구니 속 물품지우기 1개
	
	// 4) 장바구니 속 물품지우기 모든
	
	// 5) 장바구니 조회
	public ArrayList<HashMap<String, Object>> getCart(Customer customer) {
		ArrayList<HashMap<String, Object>> list = null;
		
		this.cartDao = new CartDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			list = cartDao.selectCart(conn, customer);
			
			if(list == null) {
				System.out.println("장바구니 조회 성공!");
			} else {
				System.out.println("장바구니 조회 실패!");
				throw new Exception();
			}
			
			conn.commit();
			
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
}
