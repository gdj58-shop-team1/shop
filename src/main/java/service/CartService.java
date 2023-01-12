package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dao.CartDao;
import util.DBUtil;
import vo.Cart;
import vo.Customer;

public class CartService {
	private CartDao cartDao;
	private DBUtil dbUtil;
	
	// 1) 장바구니 없던 물품 추가(회원)
	public void addCart(Cart cart) {
		int row = 0;
		
		this.cartDao = new CartDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			row = cartDao.insesrtCart(conn, cart);
			
			if(row == 1) {
				System.out.println("카트에 물품 추가 성공(회원)");
			} else {
				System.out.println("카트에 물품 추가 실패(회원)");
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
	}
	// 2) 장바구니 있던 물건 수량 변경 (회원)
	public void modifyCart(Cart cart, int modifyOrderQuantity) {
		int row = 0;
		
		this.cartDao = new CartDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			row = cartDao.updateCart(conn, cart, modifyOrderQuantity);
			
			if(row == 1) {
				System.out.println("카트의 물품 수량 변경 성공(회원)");
			} else {
				System.out.println("카트의 물품 수량 변경 실패(회원)");
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
	}
	
	// 3) 장바구니 속 물품지우기 1개
	public void removeCartOne(Cart cart) {
		int row = 0;
		
		this.cartDao = new CartDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			row = cartDao.deleteCartOne(conn, cart);
			if(row == 1) {
				System.out.println("장바구니 물품 1개 지우기 성공!");
			} else {
				System.out.println("장바구니 물품 1개 지우기 실패!");
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
	}
	
	// 4) 장바구니 속 물품지우기 모든
	public void removeCartAll(Cart cart) {
		int row = 0;
		
		this.cartDao = new CartDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			row = cartDao.deleteCartAll(conn, cart);
			if(row != 0) {
				System.out.println("장바구니 물품 모두 지우기 성공!");
			} else {
				System.out.println("장바구니 물품 모두 지우기 실패!");
				return;
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
	}
	
	// 5) 장바구니 조회
	public ArrayList<HashMap<String, Object>> getCartList(Customer customer) {
		ArrayList<HashMap<String, Object>> list = null;
		
		this.cartDao = new CartDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			list = cartDao.selectCartList(conn, customer);
			
			if(list != null) {
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
	
	// 6) 장바구니 DB속에 있는 물건인지 확인
	public boolean confirmCart(Cart cart) {
		boolean flag = true;
		
		this.cartDao = new CartDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			flag = cartDao.selectCart(conn, cart);
			
			if(flag == false) {
				System.out.println("장바구니에 담겨있지않는 물건");
			} else {
				System.out.println("장바구니에 담겨있는 물건");
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
		return flag;
	}
	
}
