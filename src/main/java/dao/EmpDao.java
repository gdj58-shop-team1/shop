package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.Customer;

public class EmpDao {
	
	
	
	// 6) customerId 조회
	public int selectCustomerId(Connection conn, String id) throws Exception {
		int row = 0;
		
		String sql = "SELECT emp_id"
				+ " FROM emp"
				+ " WHERE emp_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		
		ResultSet rs = stmt.executeQuery();
		
		row = rs.getRow(); // 몇개의 행인지 
		
		return row;
	}
}
