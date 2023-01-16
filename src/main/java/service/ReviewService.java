package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import dao.CustomerDao;
import dao.PointHistoryDao;
import dao.ReviewDao;
import util.DBUtil;
import vo.PointHistory;
import vo.Review;

public class ReviewService {
	private ReviewDao reviewDao;
	private PointHistoryDao pointHistoryDao;
	private CustomerDao customerDao;
	private DBUtil dbUtil;
	
	// 1) 회원
	// 1-1) 회원 리뷰 조회(본인 작성 리뷰만)
	public ArrayList<HashMap<String, Object>> getReviewByCustomerId(String customerId){
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		reviewDao = new ReviewDao();
		dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getReviewByCustomerId(ReviewService) db 접속");
			reviewList = reviewDao.selectReviewByCustomerId(conn, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return reviewList;
	}
	// 1-2) 회원 리뷰 작성(본인 작성 리뷰만)
	public int addReview(Review paramReview, String customerId){
		int row = 0;
		reviewDao = new ReviewDao();
		pointHistoryDao = new PointHistoryDao();
		customerDao = new CustomerDao();
		dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("addReview(ReviewService) db 접속");
			conn.setAutoCommit(false);
			
			// 1) 리뷰 작성
			int reviewRow = reviewDao.insertReview(conn, paramReview);
			if(reviewRow == 1) {
				System.out.println("리뷰입력 임시 성공");
			} else {
				System.out.println("리뷰입력 임시 실패");
				throw new Exception();
			}
			
			// 2) 포인트 히스토리 입력
			PointHistory paramPoint = new PointHistory();
			paramPoint.setOrderCode(paramReview.getOrderCode());
			paramPoint.setPoint(500);
			paramPoint.setPointKind("적립");
			int pointHsRow = pointHistoryDao.insertPoint(conn, paramPoint);
			if(pointHsRow == 1) {
				System.out.println("포인트 입력 성공");
			} else {
				System.out.println("포인트 입력 실패");
				throw new Exception();
			}
			
			// 3) 고객 포인트 수정
			int point = paramPoint.getPoint();
			int pointRow = customerDao.updatePoint(conn, customerId, point);
			if(pointRow == 1) {
				System.out.println("포인트 수정 성공");
			} else {
				System.out.println("포인트 수정 실패");
				throw new Exception();
			}
			row = 1;
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
		return row;
	}
	// 1-3) 회원 리뷰 수정(본인 작성 리뷰만)
	public int modifyReview(Review paramReview){
		int row = 0;
		reviewDao = new ReviewDao();
		dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("modifyReview(ReviewService) db 접속");
			conn.setAutoCommit(false);
			row = reviewDao.updateReview(conn, paramReview);
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
		return row;
	}

	// 1-4) 리뷰 수정시 수정 전 내용 불러오기
	public HashMap<String, Object> getReviewByOrderCode(int orderCode){
		HashMap<String, Object> map = null;
		reviewDao = new ReviewDao();
		dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getReviewByOrderCode(ReviewService) db 접속");
			map = reviewDao.selectReviewByOrderCode(conn, orderCode);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return map;
	}
	
	// 1-5) 상품페이지 리뷰 조회 (goodsOne)
	public ArrayList<HashMap<String, Object>> getReviewByGoodsCode(int goodsCode){
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		reviewDao = new ReviewDao();
		dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getReviewByGoodsCode(ReviewService) db 접속");
			reviewList = reviewDao.selectReviewByGoodsCode(conn, goodsCode);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return reviewList;
	}
	
	// 2) 사원
	// 2-1) 본인이 등록한 상품의 리뷰만 조회(사원 레벨 1,2)
	public ArrayList<HashMap<String, Object>> getReviewByEmpId(String empId){
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		reviewDao = new ReviewDao();
		dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getReviewByEmpId(ReviewService) db 접속");
			reviewList = reviewDao.selectReviewByEmpID(conn, empId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return reviewList;
	}
	
	// 2-2) 모든 리뷰 조회(관리자)
	public ArrayList<HashMap<String, Object>> getReviewAll(){
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		reviewDao = new ReviewDao();
		dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getReviewAll(ReviewService) db 접속");
			reviewList = reviewDao.selectReviewAll(conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return reviewList;
	}
}
