package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class SiteCounterDao {
	// 1) 오늘 첫 접속자가 발생시 insert
	public int insertSiteCounter(Connection conn) throws Exception {
		int row = 0;
		String sql = "INSERT INTO site_counter (counter_date, counter_num) VALUES(CURDATE(), 1)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		row = stmt.executeUpdate();
		
		return row;
		
	}
	// 2) 오늘 첫 접속자가 아닐때 update
	public int updateSiteCounter(Connection conn) throws Exception {
		int row = 0;
		String sql ="UPDATE site_counter SET counter_num = counter_num+1"
				+ " WHERE counter_date = CURDATE()";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		row = stmt.executeUpdate();
		
		return row;
	}
		
	// 3) 오늘 접속자 수 확인 select
	// 반환 0 -> 1번 insert실행, 반환 -> 0이 아닐때 2번 update실행
	public int selectTodaySiteCounter(Connection conn) throws Exception {
		int todayCount = 0;
		String sql = "SELECT counter_num todayCount"
				+ " FROM site_counter"
				+ " WHERE counter_date = CURDATE()";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			todayCount = rs.getInt("todayCount");
		}
		return todayCount;
		
	}
	// 4) 전체 접속자 수 확인 select
	public int selectTotalSiteCounter(Connection conn) throws Exception {
		int totalCount = 0;
		String sql = "SELECT SUM(counter_num) totalCount"
				+ " FROM site_counter";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalCount = rs.getInt("totalCount");
		}
		return totalCount;
	}
}
