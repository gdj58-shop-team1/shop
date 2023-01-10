package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.Customer;
import vo.Emp;

public class EmpDao {
	// 1) emp 회원가입
	public int insertEmp(Connection conn, Emp emp) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO emp(emp_id, emp_pw, emp_name)"
				+ " VALUES(?, ?, ?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, emp.getEmpId());
		stmt.setString(2, emp.getEmpPw());
		stmt.setString(3, emp.getEmpName());
		
		row = stmt.executeUpdate(); // 1 반환 시, 회원가입 성공
		
		stmt.close();
		return row;
		
	}
	
	// 2) emp 수정
	public int updateEmp(Connection conn, Emp emp) throws Exception {
		int row = 0;
		
		String sql = "UPDATE emp SET"
				+ " emp_name = ?"
				+ " WHERE emp_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, emp.getEmpName());
		stmt.setString(2, emp.getEmpId());

		row = stmt.executeUpdate(); // 1 반환 시, emp수정 성공
		return row;
		
	}
	
	// 3) emp 비밀번호 수정
	public int updateEmpPw(Connection conn, Emp emp, String newPw) throws Exception {
		int row = 0;
		
		String sql = "UPDATE emp SET"
				+ " emp_pw = ?"
				+ " WHERE emp_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, emp.getEmpId());
		
		row = stmt.executeUpdate(); // 1 반환 시, 비밀번호 변경 성공
		
		stmt.close();
		return row;
		
	}
	
	// 4) emp 활성화/비활성화
	public int updateEmpActive(Connection conn, Emp emp) throws Exception {
		int row = 0;
		
		String sql = "UPDATE emp SET"
				+ " active = ?"
				+ " WHERE emp_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, emp.getActive());
		stmt.setString(2, emp.getEmpId());
		
		row = stmt.executeUpdate(); // 1 반환 시, active 변경 성공
		
		return row;	
	}
	
	// 5) emp auth_code 변경
	public int updateEmpAuthCode(Connection conn, Emp emp) throws Exception {
		int row = 0;
		
		String sql = "UPDATE emp SET"
				+ " auth_code = ?"
				+ " WHERE emp_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, emp.getAuthCode());
		stmt.setString(2, emp.getEmpId());
		
		row = stmt.executeUpdate(); // 1 반환 시, auth_code 변경성공
		
		stmt.close();
		return row;
	}
	
	// 6) emp 탈퇴
	public int deleteEmp(Connection conn, Emp emp) throws Exception {
		int row = 0;
		
		String sql = "DELETE"
				+ " FROM emp"
				+ " WHERE emp_id = ? AND emp_pw = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, emp.getEmpId());
		stmt.setString(2, emp.getEmpPw());
		
		stmt.close();
		return row;
	}
	
	// 7) emp 로그인
	public Emp loginEmp(Connection conn, Emp emp) throws Exception {
		Emp resultEmp = null;
		
		String sql = "SELECT emp_id, emp_name, auth_code, level, active"
				+ " FROM emp"
				+ " WHERE emp_id = ? AND emp_pw = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, emp.getEmpId());
		stmt.setString(2, emp.getEmpPw());
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			resultEmp = new Emp();
			resultEmp.setEmpId(rs.getString("emp_id"));
			resultEmp.setEmpName(rs.getString("emp_name"));
			resultEmp.setAuthCode(rs.getInt("auth_code"));
			resultEmp.setLevel(rs.getInt("level"));
			resultEmp.setActive(rs.getString("active"));
		}
		
		stmt.close();
		rs.close();
		return resultEmp; // 로그인 정보 반환
	}
	
	// 8) emp 변경을 위해 기존 데이터 가져오기
	public Emp selectEmp(Connection conn, Emp emp) throws Exception {
		Emp resultEmp = null;
		
		String sql = "SELECT emp_id, emp_name, auth_code, level, active"
				+ " FROM emp"
				+ " WHERE emp_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, emp.getEmpId());
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			resultEmp = new Emp();
			resultEmp.setEmpId(rs.getString("emp_id"));
			resultEmp.setEmpName(rs.getString("emp_name"));
			resultEmp.setAuthCode(rs.getInt("auth_code"));
			resultEmp.setLevel(rs.getInt("level"));
			resultEmp.setActive(rs.getString("active"));
		}
		
		stmt.close();
		rs.close();
		return resultEmp; // 로그인 정보 반환
	}
	
	// 9) id 조회
	public int selectEmpId(Connection conn, Emp emp) throws Exception {
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
		stmt.setString(1, emp.getEmpId());
		
		ResultSet rs = stmt.executeQuery();
		
		row = rs.getRow(); // 몇개의 행인지 
		
		stmt.close();
		rs.close();
		return row;
	}
		
}
