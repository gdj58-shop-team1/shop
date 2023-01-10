package service;

import java.sql.Connection;
import java.sql.SQLException;

import dao.SiteCounterDao;
import util.DBUtil;

public class SiteCounterService {
	private SiteCounterDao siteCounterDao;
	private DBUtil dbUtil;
	
	// 1) 접속자 수 갱신(첫 접속자)
	public void addSiteCounter() {
		
		siteCounterDao = new SiteCounterDao();
		dbUtil = new DBUtil();
		
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			int row = siteCounterDao.insertSiteCounter(conn);
			
			if(row == 1) {
				System.out.println("접속자수 갱신 성공!(오늘의 첫 접속자입니다.)");
			} else {
				System.out.println("접속자수 갱신 실패!(오늘의 첫 접속자입니다.)");
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
	
	// 2) 접속자 수 갱신
	public void modifySiteCounter() {
		
		siteCounterDao = new SiteCounterDao();
		dbUtil = new DBUtil();
		
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			int row = siteCounterDao.updateSiteCounter(conn);
			
			if(row == 1) {
				System.out.println("접속자수 갱신 성공!");
			} else {
				System.out.println("접속자수 갱신 실패!");
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
	
	// 3) 오늘 접속자 수 조회
	public int getTodaySiteCounter() {
		int todaySiteCounter = 0;
		
		siteCounterDao = new SiteCounterDao();
		dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			todaySiteCounter = siteCounterDao.selectTodaySiteCounter(conn);
			
			if(todaySiteCounter != 0) {
				System.out.println("오늘의 접속자수 데이터 로딩 성공!");
			} else {
				System.out.println("오늘의 접속자수 데이터 로딩 실패!");
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
		return todaySiteCounter;
	}
	
	// 4) 전체 접속자 수 조회
	public int getTotalSiteCounter() {
		int totalSiteCounter = 0;
		
		siteCounterDao = new SiteCounterDao();
		dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			totalSiteCounter = siteCounterDao.selectTotalSiteCounter(conn);
			
			if(totalSiteCounter != 0) {
				System.out.println("총 접속자수 데이터 로딩 성공!");
			} else {
				System.out.println("총 접속자수 데이터 로딩 실패!");
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
		return totalSiteCounter;
	}
}
