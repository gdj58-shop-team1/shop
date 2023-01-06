package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.eclipse.jdt.internal.compiler.ast.ThrowStatement;

import dao.QuestionDao;
import util.DBUtil;
import vo.Customer;
import vo.Emp;
import vo.Question;

public class QuestionService {
	private QuestionDao questionDao;
	private DBUtil dbUtil;
	
	public ArrayList<HashMap<String, Object>> getQuestionForCustomer(Customer customer) {
		ArrayList<HashMap<String, Object>> list = null;
		
		this.questionDao = new QuestionDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			list = questionDao.selectQuestionForCustomer(conn, customer);
			
			if(list != null) {
				System.out.println("문의게시판(회원) 조회 성공");
			} else {
				System.out.println("문의게시판(회원) 조회 실패");
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
		return list;
	}
	
	public ArrayList<HashMap<String, Object>> getQuestionForEmp(Emp emp) {
		ArrayList<HashMap<String, Object>> list = null;

		this.questionDao = new QuestionDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			list = questionDao.selectQuestionForEmp(conn, emp);
			
			if(list != null) {
				System.out.println("문의게시판(사원) 조회 성공");
			} else {
				System.out.println("문의게시판(사원) 조회 실패");
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
		return list;
	}
	
	public HashMap<String, Object> getQuestionOne (Question question) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		this.questionDao = new QuestionDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
	
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			map = questionDao.selectQuestionOne(conn, question);
			
			if(map != null) {
				System.out.println("문의 상세보기 조회 성공");
			} else {
				System.out.println("문의 상세보기 조회 실패");
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
		return map;
	}
	public int addQuestionForCustomer(Question question) {
		int insertQuestionForCustomerRow = 0;

		this.questionDao = new QuestionDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			insertQuestionForCustomerRow = questionDao.insertQuestionForCustomer(conn, question);
			
			if(insertQuestionForCustomerRow == 1) {
				System.out.println("문의글 작성 성공");
			} else {
				System.out.println("문의글 작성 실패");
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
		return insertQuestionForCustomerRow;
	}
	
	public int modifyQuestionForCustomer(Question question) {
		int updateQuestionForCustomerRow = 0;

		this.questionDao = new QuestionDao();
		this.dbUtil = new DBUtil();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			updateQuestionForCustomerRow = questionDao.updateQuestionForCustomer(conn, question);
			
			if(updateQuestionForCustomerRow == 1) {
				System.out.println("문의글 수정 성공");
			} else {
				System.out.println("문의글 수정 실패");
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
		return updateQuestionForCustomerRow;
	}
}
