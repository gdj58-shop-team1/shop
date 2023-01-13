package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;

import dao.OrderDao;
import util.DBUtil;
import vo.Orders;

public class OrderService {
	private OrderDao orderDao;
	private DBUtil dbUtil;
	
	// 주문입력(goodsOne -> 바로 구매)
	public int addOrderDirect(Orders paramOrder){
		int row = 0;
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("insertOrderDirect(OrderService) db 접속");
			conn.setAutoCommit(false);
			row = orderDao.insertOrderDirect(conn, paramOrder);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// 포인트 처리 위한 주문코드 출력
	public int getRecentOrder(String customerId){
		int orderCode = 0;
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getRecentOrder(OrderService) db 접속");
			orderCode = orderDao.selectRecentOrder(conn, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return orderCode;
	}
	
	// 회원
	// 주문목록 출력(select) : 본인이 주문한 주문목록에 한해서
	public ArrayList<HashMap<String, Object>> getOrderListById(String customerId) {
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String, Object>>();
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getOrderListById(OrderService) db 접속");
			orderList = orderDao.selectOrderListById(conn, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return orderList;
	}
	
	// 특정 주문 출력(select) : 리뷰 또는 상품 문의글 작성시 필요한 정보 출력
	public HashMap<String, Object> getOrderByOrderCode(int orderCode){
		HashMap<String, Object> order = null;
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getOrderByOrderCode(OrderService) db 접속");
			order = orderDao.selectOrderByOrderCode(conn, orderCode);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return order;
	}
	
	// 관리자
	// 모든 주문목록 출력(select) : 모든 주문목록 출력
	public ArrayList<HashMap<String, Object>> getOrderListAll() {
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String, Object>>();
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getOrderListAll(OrderService) db 접속");
			orderList = orderDao.selectOrderListAll(conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return orderList;
	}
	
	// 주문상태 수정(update : orderList)
	public int modifyOrder(int orderCode, String orderState) {
		int row = 0;
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("modifyOrder(OrderService) db 접속");
			conn.setAutoCommit(false);
			row = orderDao.updateOrder(conn, orderCode, orderState);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// 주문하기
	// 1) insert order
	// 2) insert point(customer)
	// 3) insert point_history
	public int addOrderFromCart(Orders Orders, int usePoint) {
		int row = 0;
		
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("modifyOrder(OrderService) db 접속");
			conn.setAutoCommit(false);
			row = orderDao.updateOrder(conn, orderCode, orderState);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return usePoint;
		
	}
}
