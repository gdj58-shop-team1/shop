package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import dao.CustomerDao;
import dao.OutidDao;
import dao.PwHistoryDao;
import util.DBUtil;
import vo.Customer;
import vo.Outid;
import vo.PwHistory;

public class CustomerService {
	private CustomerDao customerDao;
	private OutidDao outidDao;
	private PwHistoryDao pwHistoryDao;
	private DBUtil dbUtil;

	// 1) 회원가입
	public int addCustomer(Customer customer) {
		int selectIdRow = 0;
		int insertCustoemrRow = 0;
		int insertPwHistoryRow = 0;
		
		this.customerDao = new CustomerDao();
		this.pwHistoryDao = new PwHistoryDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			// 1-1) 아이디 중복 조회
			selectIdRow = customerDao.selectCustomerId(conn, customer);
			
			if(selectIdRow != 1) {
				System.out.println("중복되는 id가 없습니다.");
			} else {
				System.out.println("회원가입 오류 : 중복되는 id가 존재합니다.");
				throw new Exception();
			}
			
			insertCustoemrRow = customerDao.insertCustomer(conn, customer);
			
			if(insertCustoemrRow == 1) {
				System.out.println("회원가입 성공");
			} else {
				System.out.println("회원가입 실패");
				throw new Exception();
			}
			
			PwHistory pwHistory = new PwHistory();
			pwHistory.setCustomerId(customer.getCustomerId());
			pwHistory.setPw(customer.getCustomerPw());
			
			insertPwHistoryRow = pwHistoryDao.insertPwHistory(conn, pwHistory);
			if(insertPwHistoryRow == 1) {
				System.out.println("회원가입한 customer의 비밀번호 pw_history에 추가 성공");
			} else {
				System.out.println("회원가입한 customer의 비밀번호 pw_history에 추가 실패");
				throw new Exception();
			}
			
			conn.commit();
		} catch(Exception e) {
			try {
				conn.rollback();
				System.out.println("예외 발생 -> 모든 DB접근 rollback");
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
		
		return insertCustoemrRow;
	}
	// 2) 회원수정
	public Customer modifyCustomer(Customer customer) {
		int row = 0;
		Customer resultCustomer = null;
				
		this.customerDao = new CustomerDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
				
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			row = customerDao.updateCustomer(conn, customer);
			
			if(row == 1) { // 회원 수정 성공 시,
				System.out.println("회원수정 성공");
			} else  { // 회원 수정 실패 시,
				System.out.println("회원수정 실패");
				throw new Exception();
			}
			
			resultCustomer = customerDao.selectCustomer(conn, customer);
			
			if(resultCustomer != null) {
				System.out.println("회원수정 후 , 재 로딩 성공");
			} else {
				System.out.println("회원수정 후 , 재 로딩 실패");
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
		
		return resultCustomer;
	}
	
	// 3) 비밀번호수정
	public int modifyCustomerPw(Customer customer, String newCustomerPw) {
		int selectPwHistoryRow = 0;
		int updateCustomerPwRow = 0;
		int insertPwHistoryRow = 0;
		
		ArrayList<PwHistory> list = null;
		
		this.customerDao = new CustomerDao();
		this.pwHistoryDao = new PwHistoryDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			// 1) pw_history 에서 검색
			selectPwHistoryRow = pwHistoryDao.selectPwHistory(conn, customer, newCustomerPw);
			
			if(selectPwHistoryRow == 1) {
				System.out.println("비밀번호 수정 오류 : 최근 사용한 비밀번호 입니다.");
				throw new Exception();
			}
			
			// 2) 비밀번호 수정	
			updateCustomerPwRow = customerDao.updateCustomerPw(conn, customer, newCustomerPw);
			
			if(updateCustomerPwRow != 1) {
				System.out.println("비밀번호 수정 오류 : 비밀번호 수정 실패");
				throw new Exception();
			}
			
			// 3) 새로운 비밀번호 pw_history에 추가
			PwHistory pwHistory = new PwHistory();
			pwHistory.setCustomerId(customer.getCustomerId());
			pwHistory.setPw(newCustomerPw);
			
			insertPwHistoryRow = pwHistoryDao.insertPwHistory(conn, pwHistory);
			if(insertPwHistoryRow == 1) {
				System.out.println("회원가입한 customer의 비밀번호 pw_history에 추가 성공");
			} else {
				System.out.println("회원가입한 customer의 비밀번호 pw_history에 추가 실패");
				throw new Exception();
			}
			
			// 4) 이력 3개 초과인지 확인
			list = pwHistoryDao.selectPwHistoryList(conn, customer);
			System.out.println("pw_history size :" + list.size());
			if(list.size() > 3) {
				// 5) 이력 3개 초과시, 가장 오래된 비밀번호 정보 가져오기, 내림차순했기 때문에 가장 list에서 가장 첫번째 값이 제일 오래된 값
				PwHistory oldPwHistory = list.get(0);
				
				// 6) 이력 3개 초과시, 가장 오래된 비밀번호 삭제
				if(pwHistoryDao.deletePwHistory(conn, oldPwHistory) == 1) {
					System.out.println("비밀번호 이력 3개 초과!! -> 가장 오래된 비밀번호 삭제 성공!");
				} else {
					System.out.println("비밀번호 이력 3개 초과!! -> 가장 오래된 비밀번호 삭제 실패!");
					throw new Exception();
				}
			}		
			
			conn.commit();
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return updateCustomerPwRow; // 비밀번호 수정결과를 반환
	}
	
	// 4) 회원탈퇴
	public int removeCustomer(Customer customer) {
		int deleteCustomerRow = 0;
		int insertOutidRow = 0;
		
		this.customerDao = new CustomerDao();
		this.outidDao = new OutidDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
				
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			Outid outid = new Outid();
			outid.setId(customer.getCustomerId());
			
			// 1) outid에 id남기기
			insertOutidRow = outidDao.insertOutid(conn, outid);
			
			if(insertOutidRow == 1) {
				System.out.println("oudid 삽입성공");
			} else {
				System.out.println("oudid 삽입실패");
				throw new Exception();
			}
			
			// 2) 회원탈퇴
			deleteCustomerRow = customerDao.deleteCustomer(conn, customer);
			
			if(deleteCustomerRow == 1) {
				System.out.println("회원탈퇴 성공");
			} else {
				System.out.println("회원탈퇴 실패");
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
		
		return deleteCustomerRow;
	}
	
	// 5) 로그인
	public Customer loginCustomer(Customer customer) {
		Customer loginCustomer = null;
		
		this.customerDao = new CustomerDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			loginCustomer = customerDao.loginCustomer(conn, customer);
			
			if(loginCustomer != null) {
				System.out.println("회원 로그인 성공");
			} else {
				System.out.println("회원 로그인 실패");
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
		return loginCustomer;
	}
	
	// 6) 회원정보변경을 위해 기존 데이터 가져오기
	public Customer getCustomer(Customer customer) {
		Customer resultCustomer = null;
		
		this.customerDao = new CustomerDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			resultCustomer = customerDao.selectCustomer(conn, customer);
			
			if(resultCustomer != null) {
				System.out.println("회원 정보가져오기 성공");
			} else {
				System.out.println("회원 정보가져오기 실패");
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
		return resultCustomer;
	}
}
