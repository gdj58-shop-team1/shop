package service;

import java.sql.Connection;
import java.sql.SQLException;

import dao.CustomerDao;
import dao.EmpDao;
import dao.OutidDao;
import dao.PwHistoryDao;
import util.DBUtil;
import vo.Customer;
import vo.Emp;
import vo.Outid;

public class EmpService {
	
	private EmpDao empDao;
	private OutidDao outidDao;
	private DBUtil dbUtil;
	
	// 1) 회원가입
	public int addEmp(Emp emp) {
		int selectIdRow = 0;
		int insertEmpRow = 0;
		
		this.empDao = new EmpDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			// 1-1) 아이디 중복 조회
			selectIdRow = empDao.selectEmpId(conn, emp);
			
			if(selectIdRow != 1) {
				System.out.println("중복되는 id가 없습니다.");
			} else {
				System.out.println("관리자 회원가입 오류 : 중복되는 id가 존재합니다.");
				throw new Exception();
			}
			
			insertEmpRow = empDao.insertEmp(conn, emp);
			
			if(insertEmpRow == 1) {
				System.out.println("관리자 회원가입 성공");
			} else {
				System.out.println("관리자 회원가입 실패");
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
		
		return insertEmpRow;
	}
	
	// 2) emp 수정
	public Emp modifyEmp(Emp emp) {
		int updateEmpRow = 0;
		Emp resultEmp = null;
				
		this.empDao = new EmpDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
				
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			updateEmpRow = empDao.updateEmp(conn, emp);
			
			if(updateEmpRow == 1) { // 회원 수정 성공 시,
				System.out.println("관리자 회원수정 성공");
			} else  { // 회원 수정 실패 시,
				System.out.println("관리자 회원수정 실패");
				throw new Exception();
			}
			
			resultEmp = empDao.selectEmp(conn, emp);
			
			if(resultEmp != null) {
				System.out.println("관리자 회원수정 후 , 재 로그인 성공");
			} else {
				System.out.println("관리자 회원수정 후 , 재 로그인 실패");
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
		
		return resultEmp;
	}
	
	// 3) emp 비밀번호 수정
	public int modifyEmpPw(Emp emp, String newPw) {
		this.empDao = new EmpDao();
		this.dbUtil = new DBUtil();
		
		int updateEmpPwRow = 0;
		
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			updateEmpPwRow = empDao.updateEmpPw(conn, emp, newPw);
			
			if(updateEmpPwRow == 1) {
				System.out.println("비밀번호 수정 성공");
			} else {
				System.out.println("비밀번호 수정 오류 : 비밀번호 수정 실패");
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
		return updateEmpPwRow;
	}
	
	// 4) emp 활성화/비활성화
	public int modifyEmpActive(Emp emp) {
		this.empDao = new EmpDao();
		this.dbUtil = new DBUtil();
		
		int updateEmpAciveRow = 0;
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			updateEmpAciveRow = empDao.updateEmpActive(conn, emp);
			
			if(updateEmpAciveRow == 1) {
				System.out.println("직원 Active 변경 성공");
			} else {
				System.out.println("직원 Active 변경 실패");
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
		
		return updateEmpAciveRow;
	}
	
	// 5) emp 레벨 변경
	public int modifyEmpAuthCode(Emp emp) {
		this.empDao = new EmpDao();
		this.dbUtil = new DBUtil();
		
		int updateEmpAuthCodeRow = 0;
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			updateEmpAuthCodeRow = empDao.updateEmpAuthCode(conn, emp);
			
			if(updateEmpAuthCodeRow == 1) {
				System.out.println("직원 AuthCode 변경 성공");
			} else {
				System.out.println("직원 AuthCode 변경 실패");
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
		return updateEmpAuthCodeRow;
	}
	
	// 6) emp 탈퇴
	public int removeEmp(Emp emp) {
		this.empDao = new EmpDao();
		this.outidDao = new OutidDao();
		this.dbUtil = new DBUtil();
		
		int insertOutidRow = 0;
		int deleteEmpRow = 0;
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			Outid outid = new Outid();
			outid.setId(emp.getEmpId());
			
			// 1) outid에 id남기기
			insertOutidRow = outidDao.insertOutid(conn, outid);
			
			if(insertOutidRow == 1) {
				System.out.println("oudid 삽입성공");
			} else {
				System.out.println("oudid 삽입실패");
				throw new Exception();
			}
						
			deleteEmpRow = empDao.deleteEmp(conn, emp);
			
			if(deleteEmpRow == 1) {
				System.out.println("직원 탈퇴 성공");
			} else {
				System.out.println("직원 탈퇴 실패");
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
		return deleteEmpRow;
	}
	
	// 7) emp 로그인
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
				System.out.println("emp 로그인 성공");
			} else {
				System.out.println("emp 로그인 실패");
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
	
	// 8) emp 수정을 위해 기존데이터 가져오기
	public Emp getEmp(Emp emp) {
		Emp resultEmp = null;
		
		this.empDao = new EmpDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			resultEmp = empDao.selectEmp(conn, emp);
			
			if(resultEmp != null) {
				System.out.println("emp 데이터 가져오기 성공");
			} else {
				System.out.println("emp 데이터 가져오기 실패");
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
		
		return resultEmp;
	}
}
