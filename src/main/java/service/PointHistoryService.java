package service;

import java.sql.Connection;
import java.util.ArrayList;

import dao.CustomerDao;
import dao.PointHistoryDao;
import util.DBUtil;
import vo.PointHistory;

public class PointHistoryService {
	private PointHistoryDao pointHistoryDao;
	private CustomerDao customerDao;
	private DBUtil dbUtil;
	
	// 포인트 내역 조회(select)
	public ArrayList<PointHistory> getPointHistoryList(String customerId){
		ArrayList<PointHistory> pointList = new ArrayList<PointHistory>();
		this.pointHistoryDao = new PointHistoryDao();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getPointHistoryList(PointHistoryService) db 진입");
			pointList = pointHistoryDao.selectPointHistoryList(conn, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return pointList;
	}
	
	// 포인트 적립/사용(insert)
	public int addPoint(PointHistory paramPoint){
		int row = 0;
		this.pointHistoryDao = new PointHistoryDao();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("addGetPoint(PointHistoryService) db 진입");
			conn.setAutoCommit(false);
			row = pointHistoryDao.insertPoint(conn, paramPoint);
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
	
	// 포인트 처리(히스토리 남기고 고객 포인트 변경)
	public boolean pointProcess(String customerId, PointHistory paramPoint) {
		boolean processResult = false;
		this.pointHistoryDao = new PointHistoryDao();
		this.customerDao = new CustomerDao();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("pointProcess(PointHistoryService) db 진입");
			conn.setAutoCommit(false);
			
			// 1) 포인트 입력
			int insertRow = pointHistoryDao.insertPoint(conn, paramPoint);
			if(insertRow == 1) {
				System.out.println("포인트 입력 성공");
			} else {
				System.out.println("포인트 입력 실패");
				throw new Exception();
			}
			
			// 2) 고객 포인트 수정
			int point = paramPoint.getPoint();
			int updateRow = customerDao.updatePoint(conn, customerId, point);
			if(updateRow == 1) {
				System.out.println("포인트 수정 성공");
			} else {
				System.out.println("포인트 수정 실패");
				throw new Exception();
			}
			
			conn.commit();
			processResult = true;
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
		return processResult;
	}
	
}
