package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Customer;
import vo.PwHistory;

public class PwHistoryDao {
	
	// 1) 비밀번호 이력 조회
	public int selectPwHistory(Connection conn, Customer customer, String newCustomerPw) throws Exception {
		int row = 0;
		
		String sql = "SELECT customer_id, pw"
				+ " FROM pw_history"
				+ " WHERE customer_id = ? AND pw = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, newCustomerPw);
		
		ResultSet rs = stmt.executeQuery();
		
		row = rs.getRow(); // 새로입력한 비밀번호가 기존 비밀번호 이력에 남아있을 시, row = 1 반환
		
		return row;
	}
	
	// 2) 비밀번호 이력 삽입
	public int insertPwHistory(Connection conn, PwHistory pwHistory) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO pw_history (customer_id, pw)"
				+ " VALUES (?,?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, pwHistory.getCustomerId());
		stmt.setString(2, pwHistory.getPw());
		
		row = stmt.executeUpdate(); // 삽입 성공시 row = 1
		
		return row;  
	}
	
	// 3) 비밀번호 이력 삭제
	public int deletePwHistory(Connection conn, PwHistory pwHistory) throws Exception {
		int row = 0;
				
		String sql = "DELETE"
				+ " FROM pw_history"
				+ " WHERE customer_id = ? AND createdate = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, pwHistory.getCustomerId());
		stmt.setString(2, pwHistory.getPw());
		
		row = stmt.executeUpdate(); // 삭제 성공시 row = 1
		
		return row;  
	}
	
	// 4) ArrayList<PwHistory> 가져오기
	public ArrayList<PwHistory> selectPwHistoryList(Connection conn, Customer customer) throws Exception {
		ArrayList<PwHistory> list = null;
		
		String sql = "SELECT customer_id, pw, createdate"
				+ " FROM pw_history"
				+ " WHERE customer_id = ?"
				+ " ORDER BY createdate DESC";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		
		ResultSet rs = stmt.executeQuery();
		
		list = new ArrayList<PwHistory>();
		
		while(rs.next()) {
			PwHistory pwHistory = new PwHistory();
			pwHistory.setCustomerId(sql);
			pwHistory.setPw(sql);
			pwHistory.setCreatedate(sql);
			list.add(pwHistory);
		}
		
		return list;			
	}
}
