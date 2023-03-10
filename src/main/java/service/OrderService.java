package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.HashMap;

import dao.CustomerDao;
import dao.OrderDao;
import dao.PointHistoryDao;
import util.DBUtil;
import vo.Orders;
import vo.PointHistory;

public class OrderService {
	private OrderDao orderDao;
	private PointHistoryDao pointHistoryDao;
	private CustomerDao customerDao;
	private DBUtil dbUtil;
	
	// 주문입력(goodsOne -> 바로 구매) - 포인트 미사용
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
	
	// 주문입력(goodsOne -> 바로 구매) - 포인트 사용
	public int addOrderDirectWithPoint(Orders paramOrder, String customerId, int usedPoint){
		int row = 0;
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		this.customerDao = new CustomerDao();
		this.pointHistoryDao = new PointHistoryDao();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("insertOrderDirect(OrderService) db 접속");
			conn.setAutoCommit(false);
			
			// 1) 주문 임시처리
			int orderRow = orderDao.insertOrderDirect(conn, paramOrder);
			if(orderRow == 1) {
				System.out.println("주문 임시입력 성공");
			} else {
				System.out.println("주문 임시입력 실패");
				throw new Exception();
			}
			
			// 2) 포인트 처리 위한 주문 코드 출력
			int orderCode = orderDao.selectRecentOrder(conn, customerId);
			
			// 포인트 처리 메서드에 들어갈 매개변수
			PointHistory paramPoint = new PointHistory(); 
			paramPoint.setOrderCode(orderCode);
			paramPoint.setPoint(usedPoint);
			paramPoint.setPointKind("사용");
			
			// 3) 포인트 입력
			int insertRow = pointHistoryDao.insertPoint(conn, paramPoint);
			if(insertRow == 1) {
				System.out.println("포인트 입력 성공");
			} else {
				System.out.println("포인트 입력 실패");
				throw new Exception();
			}
			
			// 4) 고객 포인트 수정
			int updateRow = customerDao.updatePoint(conn, customerId, usedPoint);
			if(updateRow == 1) {
				System.out.println("포인트 수정 성공");
			} else {
				System.out.println("포인트 수정 실패");
				throw new Exception();
			}

			conn.commit();
			row = 1;
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
	
	// 주문상태( -> 주문취소)
	public void modifyOrderCancel(String customerId, int orderCode, String orderState, int point) {
		int updateOrderRow = 0;
		int updatePointRow = 0;
		int insertPointRow = 0;
		
		Connection conn = null;
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		this.customerDao = new CustomerDao();
		this.pointHistoryDao = new PointHistoryDao();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("modifyOrderCancel(OrderService) db 접속");
			conn.setAutoCommit(false);
			
			updateOrderRow = orderDao.updateOrder(conn, orderCode, orderState);
			if(updateOrderRow == 1) {
				System.out.println("주문 상태 변경 성공");
			} else {
				System.out.println("주문 상태 변경 실패");
				return;
			}
			
			if(orderState.equals("주문취소")) { // 주문취소 상태로 변경 시, 포인트를 돌려주기 위함
				
				// 1) 포인트 반환
				updatePointRow = customerDao.updatePoint(conn, customerId, point);
				
				if(updatePointRow == 1) {
					System.out.println("고객 포인트 변경 성공");
				} else {
					System.out.println("고객 포인트 변경 실패");
					return;
				}
				// 2) 포인트 내역 추가
				PointHistory pointHistory = new PointHistory();
				pointHistory.setOrderCode(orderCode);
				pointHistory.setPointKind("반환");
				pointHistory.setPoint(point);
				
				insertPointRow = pointHistoryDao.insertPoint(conn, pointHistory);
				if(insertPointRow == 1) {
					System.out.println("포인트 내역 추가 성공");
				} else {
					System.out.println("포인트 내역 추가 실패");
					return;
				}
			}
			
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
	}
	
	// 주문하기
	// 1) insert order
	// 2) update point(customer)
	// 3) insert point_history
	public void addOrderFromCart(Orders orders, int shareUsePoint) {
		int insertOrderRow = 0;
		int updatePointRow = 0;
		int insertPointHistoryRow = 0;
		
		this.dbUtil = new DBUtil();
		this.orderDao = new OrderDao();
		this.customerDao = new CustomerDao();
		this.pointHistoryDao = new PointHistoryDao();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			// 1) insert order
			HashMap<String, Integer> map = orderDao.insertOrderFromCart(conn, orders);
			System.out.println("service 디버깅 : goodsCode" + orders.getGoodsCode());
			if(map.get("row") == 1) {
				System.out.println("주문 추가 성공!");
			} else {
				System.out.println("주문 추가 실패!");
				return;
			}
			
			int orderCode = map.get("autoKey");
			System.out.println("orderCode : " + orderCode);
			
			// 2) update point(customer)
			updatePointRow = customerDao.updatePoint(conn, orders.getCustomerId(), (shareUsePoint * -1));
			if(updatePointRow == 1) {
				System.out.println("point 수정 성공!");
			} else {
				System.out.println("point 수정 실패!");
				return;
			}
			
			// 3) insert point_history
			PointHistory pointHistory = new PointHistory();
			pointHistory.setOrderCode(orderCode);
			pointHistory.setPointKind("사용");
			pointHistory.setPoint((shareUsePoint * -1));
			if(shareUsePoint != 0) {
				insertPointHistoryRow = pointHistoryDao.insertPoint(conn, pointHistory);
				if(insertPointHistoryRow == 1) {
					System.out.println("point 사용내역 추가 성공!");
				} else {
					System.out.println("point 사용내역 추가 실패!");
					return;
				}
			}
			
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
	}
}
