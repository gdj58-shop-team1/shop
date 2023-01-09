package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import dao.OrderDao;
import util.DBUtil;

public class OrderService {
	private OrderDao orderDao;
	private DBUtil dbUtil;
	
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
}
