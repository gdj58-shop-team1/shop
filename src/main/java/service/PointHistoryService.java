package service;

import java.sql.Connection;
import java.util.ArrayList;

import dao.PointHistoryDao;
import util.DBUtil;
import vo.PointHistory;

public class PointHistoryService {
	private PointHistoryDao pointHistoryDao;
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
	public int pointProcess(String customerId, int point) {
		int processResult = 0;
		this.pointHistoryDao = new PointHistoryDao();
		Connection conn = null;
		
		
		return processResult;
	}
	
}
