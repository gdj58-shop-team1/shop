package service;

import java.sql.Connection;
import java.sql.SQLException;

import dao.CustomerDao;
import dao.OutidDao;
import util.DBUtil;
import vo.Customer;
import vo.Outid;

public class CustomerService {
	private CustomerDao customerDao;
	private OutidDao outidDao;
	private DBUtil dbUtil;

	// 1) 회원가입
	public int addCustomer(Customer customer) {
		int selectIdRow = 0;
		int insesrtCustoemrRow = 0;
		
		this.customerDao = new CustomerDao();
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
			
			insesrtCustoemrRow = customerDao.insertCustomer(conn, customer);
			
			if(insesrtCustoemrRow == 1) {
				System.out.println("회원가입 성공");
			} else {
				System.out.println("회원가입 실패");
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
		
		return insesrtCustoemrRow;
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
			
			resultCustomer = customerDao.loginCustomer(conn, customer);
			
			if(resultCustomer != null) {
				System.out.println("회원수정 후 , 재 로그인 성공");
			} else {
				System.out.println("회원수정 후 , 재 로그인 실패");
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
				System.out.println("로그인 성공");
			} else {
				System.out.println("로그인 실패");
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
}
