package service;

import java.sql.Connection;
import java.util.ArrayList;

import dao.OrderDao;
import dao.QuestionCommentDao;
import util.DBUtil;
import vo.QuestionComment;

public class QuestionCommentService {
	private QuestionCommentDao questionCommentDao;
	private DBUtil dbUtil;
	
	// 1) 문의 댓글리스트 조회
	public  ArrayList<QuestionComment> getQuestionCommentList(QuestionComment questionComment) {
		ArrayList<QuestionComment> list = null;
		
		this.dbUtil = new DBUtil();
		this.questionCommentDao = new QuestionCommentDao();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			list = questionCommentDao.selectQuestionCommentList(conn, questionComment);
			
			if(list != null) {
				System.out.println("문의 댓글 조회 성공");
			} else {
				System.out.println("문의 댓글 조회 실패");
			}
			
 			conn.commit(); 
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return list;
	}
	
	// 문의 댓글 작성
	public void addQuestionComment(QuestionComment questionComment) {
		int insertQuestionCommnetRow = 0;
		
		this.dbUtil = new DBUtil();
		this.questionCommentDao = new QuestionCommentDao();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			insertQuestionCommnetRow = questionCommentDao.insertQuestionCommentList(conn, questionComment);
			
			if(insertQuestionCommnetRow == 1) {
				System.out.println("문의 댓글 삽입 성공");
			} else {
				System.out.println("문의 댓글 삽입 실패");
			}
			
 			conn.commit(); 
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	// 문의 댓글 삭제
	public void removeQuestionComment(QuestionComment questionComment) {
		int deleteQuestionCommnetRow = 0;
		
		this.dbUtil = new DBUtil();
		this.questionCommentDao = new QuestionCommentDao();
		
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			deleteQuestionCommnetRow = questionCommentDao.deleteQuestionCommentList(conn, questionComment);
			
			if(deleteQuestionCommnetRow == 1) {
				System.out.println("문의 댓글 삭제 성공");
			} else {
				System.out.println("문의 댓글 삭제 실패");
			}
			
 			conn.commit(); 
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
