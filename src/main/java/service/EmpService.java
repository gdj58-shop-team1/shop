package service;

import java.sql.Connection;
import java.sql.SQLException;

import dao.CustomerDao;
import dao.EmpDao;
import util.DBUtil;
import vo.Emp;

public class EmpService {
	private EmpDao empDao;
	private DBUtil dbUtil;
	// 1) 직원 회원가입
	
	// 2) 직원 수정
	
	// 3) 직원 비밀번호 수정
	
	// 4) 직원 활성화/비활성화
	
	// 5) 직원 레벨 변경
	
	// 6) 직원 탈퇴
	
	// 7) 직원 로그인
	public Emp loginEmp(Emp emp) {
		Emp loginEmp = null;
		
		this.empDao = new EmpDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			loginEmp = empDao.loginEmp(conn, emp);
			
			if(loginEmp != null) {
				System.out.println("직원 로그인 성공");
			} else {
				System.out.println("직원 로그인 실패");
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
		
		return loginEmp;
	}
}
