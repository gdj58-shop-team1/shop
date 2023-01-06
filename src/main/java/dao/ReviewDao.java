package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Review;

public class ReviewDao {
	
	// 1) 회원
	// 1-1) 회원 리뷰 조회(본인 작성 리뷰만) : 마이페이지 - 리뷰관리
	public ArrayList<HashMap<String, Object>> selectReviewByCustomerId(Connection conn, String customerId) throws Exception{
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT o.order_code orderCode"
				+ ", o.goods_code goodsCode"
				+ ", o.customer_id customerId"
				+ ", r.review_memo reviewMemo"
				+ ", r.createdate createdate"
				+ " FROM review r Inner JOIN orders o"
				+ "	on r.order_code = o.order_code"
				+ " WHERE o.customer_id = ?;";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		rs = stmt.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("reviewMemo", rs.getString("reviewMemo"));
			map.put("createdate", rs.getString("createdate"));
			reviewList.add(map);
		}
		
		rs.close();
		stmt.close();
		return reviewList;
	}
	
	// 1-2) 회원 리뷰 작성(본인 작성 리뷰만) 
	public int insertReview(Connection conn, Review paramReview) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO review (order_code, review_memo) VALUES (?, ?)";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramReview.getOrderCode());
		stmt.setString(2, paramReview.getReviewMemo());
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;
	}
	
	// 1-3) 회원 리뷰 수정(본인 작성 리뷰만)
	public int updateReview(Connection conn, Review paramReview) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE reivew review_memo = ? WHERE order_code = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramReview.getReviewMemo());
		stmt.setInt(2, paramReview.getOrderCode());
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;
	}
	
	// 2) 사원
	// 2-1) 본인이 등록한 상품의 리뷰만 조회(사원 레벨 1,2)
	public ArrayList<HashMap<String, Object>> selectReviewByEmpID(Connection conn, String empId) throws Exception{
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT o.order_code orderCode"
				+ ", g.goods_code goodsCode"
				+ ", r.review_memo reviewMemo"
				+ ", o.customer_id customerId"
				+ ", o.order_state orderState"
				+ ", r.createdate createdate"
				+ " FROM review r INNER JOIN orders o"
				+ "	ON r.order_code = o.order_code"
				+ "		INNER JOIN goods"
				+ "		ON g.goods_code = o.goods_code"
				+ " WHERE g.emp_id = ?;";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		rs = stmt.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("reviewMemo", rs.getString("reviewMemo"));
			map.put("customerId", rs.getString("customerId"));
			map.put("orderState", rs.getString("orderState"));
			map.put("createdate", rs.getString("createdate"));
			reviewList.add(map);
		}
		rs.close();
		stmt.close();
		return reviewList;
	}
	
	// 2-2) 모든 리뷰 조회(관리자)
	public ArrayList<HashMap<String, Object>> selectReviewAll(Connection conn) throws Exception{
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT o.order_code orderCode"
				+ ", g.goods_code goodsCode"
				+ ", r.review_memo reviewMemo"
				+ ", o.customer_id customerId"
				+ ", o.order_state orderState"
				+ ", r.createdate createdate"
				+ " FROM review r INNER JOIN orders o"
				+ "	ON r.order_code = o.order_code"
				+ "		INNER JOIN goods"
				+ "		ON g.goods_code = o.goods_code"
				+ " WHERE g.emp_id = ?;";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("reviewMemo", rs.getString("reviewMemo"));
			map.put("customerId", rs.getString("customerId"));
			map.put("orderState", rs.getString("orderState"));
			map.put("createdate", rs.getString("createdate"));
			reviewList.add(map);
		}
		rs.close();
		stmt.close();
		return reviewList;
	}
}
