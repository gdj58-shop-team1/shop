package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.Customer;

public class CustomerDao {
	// 1) 회원가입
	public int insertCustomer(Connection conn, Customer customer) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO customer(customer_id, customer_pw, customer_name, customer_phone, point, createdate)"
				+ " VALUES(?, PASSWORD(?), ?, ?, ?, CURDATE())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		stmt.setString(3, customer.getCustomerName());
		stmt.setString(4, customer.getCustomerPhone());
		stmt.setInt(5, 500);
		
		row = stmt.executeUpdate(); // 1 반환 시, 회원가입 성공
		
		stmt.close();
		return row;
		
	}
	
	// 2) 회원수정
	public int updateCustomer(Connection conn, Customer customer) throws Exception {
		int row = 0;
		
		String sql = "UPDATE customer SET"
				+ " customer_name = ? , customer_phone = ?"
				+ " WHERE customer_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerName());
		stmt.setString(2, customer.getCustomerPhone());
		stmt.setString(3, customer.getCustomerId());
		
		row = stmt.executeUpdate(); // 1 반환 시, 회원수정 성공
		
		stmt.close();
		return row;
		
	}
	
	// 3) 비밀번호수정
	public int updateCustomerPw(Connection conn, Customer customer) throws Exception {
		int row = 0;
		
		String sql = "UPDATE customer SET"
				+ " customer_pw = PASSWORD(?)"
				+ " WHERE customer_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerPw());
		stmt.setString(2, customer.getCustomerId());
		
		row = stmt.executeUpdate(); // 1 반환 시, 비밀번호 변경 성공
		
		stmt.close();
		return row;
		
	}
	
	// 4) 회원탈퇴
	public int deleteCustomer(Connection conn, Customer customer) throws Exception {
		int row = 0;
		
		String sql = "DELETE"
				+ " FROM customer"
				+ " WHERE customer_id = ? AND customer_pw = PASSWORD(?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		
		row = stmt.executeUpdate(); // 1 반환 시, 회원탈퇴 성공
		
		stmt.close();
		return row;	
	}
	
	// 5) 로그인(세션에 담을 로그인정보)
	public Customer loginCustomer(Connection conn, Customer customer) throws Exception {
		Customer resultCustomer = null;
		
		String sql = "SELECT customer_id, customer_name, point, level"
				+ " FROM customer"
				+ " WHERE customer_id = ? AND customer_pw = PASSWORD(?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		stmt.setString(2, customer.getCustomerPw());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultCustomer = new Customer();
			resultCustomer.setCustomerId(rs.getString("customer_id"));
			resultCustomer.setCustomerName(rs.getString("customer_name"));
			resultCustomer.setPoint(rs.getInt("point"));
			resultCustomer.setLevel(rs.getInt("level"));
		}
		
		stmt.close();
		rs.close();
		return resultCustomer; // 로그인 정보 반환
	}
	
	// 6) 회원정보 변경시 정보 가져오기
	public Customer selectCustomer(Connection conn, Customer customer) throws Exception {
		Customer resultCustomer = null;
		
		String sql = "SELECT customer_id, customer_name, customer_phone, point, level"
				+ " FROM customer"
				+ " WHERE customer_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultCustomer = new Customer();
			resultCustomer.setCustomerId(rs.getString("customer_id"));
			resultCustomer.setCustomerName(rs.getString("customer_name"));
			resultCustomer.setCustomerPhone(rs.getString("customer_phone"));
			resultCustomer.setPoint(rs.getInt("point"));
			resultCustomer.setLevel(rs.getInt("level"));
		}
		
		stmt.close();
		rs.close();
		return resultCustomer; // 로그인 정보 반환
	}
	
	// 7) id 조회
	public int selectCustomerId(Connection conn, Customer customer) throws Exception {
		int row = 0;
		
		String sql = "SELECT t.id"
				+ " FROM("
				+ "		SELECT customer_id id FROM customer"
				+ "		UNION ALL"
				+ "		SELECT emp_id id FROM emp"
				+ "		UNION ALL"
				+ "		SELECT id id FROM outid"
				+ "		) t"
				+ " WHERE t.id = ?";
		
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		
		ResultSet rs = stmt.executeQuery();
		
		row = rs.getRow(); // 몇개의 행인지 
		
		stmt.close();
		rs.close();
		return row;
	}
	
	// 8) 포인트 변동
	public int updatePoint(Connection conn, String customerId, int point) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE customer"
				+ "	SET point = (point + ?)"
				+ " WHERE customer_id = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, point);
		stmt.setString(2, customerId);
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;
	}
}
