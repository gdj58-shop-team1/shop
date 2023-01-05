package service;

import java.sql.Connection;
import java.util.ArrayList;

import dao.NoticeDao;
import util.DBUtil;
import vo.Notice;

public class NoticeService {
	private NoticeDao noticeDao;
	private DBUtil dbUtil;
	
	// 공지 출력
	public ArrayList<Notice> getNoticeList(){
		ArrayList<Notice> noticeList = new ArrayList<Notice>();
		Connection conn = null;
		noticeDao = new NoticeDao();
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getNoticeList(NoticeService) db 접속");
			noticeList = noticeDao.selectNoticeList(conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return noticeList;
	}
	
	// 공지 상세보기
	public Notice getNoticeOne(int noticeCode) {
		Notice notice = new Notice();
		Connection conn = null;
		noticeDao = new NoticeDao();
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getNoticeOne(NoticeService) db 접속");
			notice = noticeDao.selectNoticeOne(conn, noticeCode);
		}  catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return notice;
	}
	
	// 공지 추가
	public int addNotice(Notice paramNotice) {
		int row = 0;
		Connection conn = null;
		noticeDao = new NoticeDao();
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("addNotice(NoticeService) db 접속");
			conn.setAutoCommit(false);
			row = noticeDao.insertNotice(conn, paramNotice);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// 공지 수정
	public int modifyNotice(Notice paramNotice) {
		int row = 0;
		Connection conn = null;
		noticeDao = new NoticeDao();
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("modifyNotice(NoticeService) db 접속");
			conn.setAutoCommit(false);
			row = noticeDao.updateNotice(conn, paramNotice);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// 공지 삭제
	public int removeNotice(int noticeCode) {
		int row = 0;
		Connection conn = null;
		noticeDao = new NoticeDao();
		dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("removeNotice(NoticeService) db 접속");
			conn.setAutoCommit(false);
			row = noticeDao.deleteNotice(conn, noticeCode);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
}
