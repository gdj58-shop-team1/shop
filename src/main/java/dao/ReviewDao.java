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
				+ ", g.goods_name goodsName"
				+ ", o.customer_id customerId"
				+ ", r.review_memo reviewMemo"
				+ ", r.createdate createdate"
				+ " FROM review r Inner JOIN orders o"
				+ "	on r.order_code = o.order_code"
				+ "		INNER JOIN goods g"
				+ "		ON o.goods_code = g.goods_code"
				+ " WHERE o.customer_id = ?"
				+ " ORDER BY r.createdate DESC";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("goodsName", rs.getString("goodsName"));
			map.put("reviewMemo", rs.getString("reviewMemo"));
			map.put("createdate", rs.getString("createdate"));
			reviewList.add(map);
		}
		
		rs.close();
		stmt.close();
		return reviewList;
	}
	
	// 1-2) 회원 리뷰 작성(본인 작성 리뷰만) : 마이페이지 - 주문내역 (구매확정 상태인 주문목록만 리뷰 작성 가능)
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
	
	// 1-3) 회원 리뷰 수정(본인 작성 리뷰만) : 마이페이지 - 주문내역(작성된 리뷰가 있을 시 수정)
	public int updateReview(Connection conn, Review paramReview) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE review SET review_memo = ? WHERE order_code = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramReview.getReviewMemo());
		stmt.setInt(2, paramReview.getOrderCode());
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;
	}
	
	// 1-4) 리뷰 수정시 수정 전 내용 불러오기
	public HashMap<String, Object> selectReviewByOrderCode(Connection conn, int orderCode) throws Exception{
		HashMap<String, Object> map = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT o.order_code orderCode"
				+ ", o.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", o.customer_id customerId"
				+ ", r.review_memo reviewMemo"
				+ ", r.createdate createdate"
				+ " FROM review r Inner JOIN orders o"
				+ "	on r.order_code = o.order_code"
				+ "		INNER JOIN goods g"
				+ "		ON o.goods_code = g.goods_code"
				+ " WHERE o.order_code = ?";				
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderCode);
		rs = stmt.executeQuery();
		if(rs.next()) {
			map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("goodsName", rs.getString("goodsName"));
			map.put("reviewMemo", rs.getString("reviewMemo"));
			map.put("createdate", rs.getString("createdate"));
		}
		
		rs.close();
		stmt.close();
		return map;
	}
	
	// 1-5) 상품페이지 리뷰 조회 (goodsOne)
	public ArrayList<HashMap<String, Object>> selectReviewByGoodsCode(Connection conn, int goodsCode) throws Exception{
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT o.order_code orderCode"
				+ ", r.review_memo reviewMemo"
				+ ", o.customer_id customerId"
				+ ", r.createdate createdate"
				+ " FROM review r INNER JOIN orders o"
				+ "	ON r.order_code = o.order_code"
				+ " WHERE o.goods_code = ?"
				+ " ORDER BY r.createdate DESC";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsCode);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("reviewMemo", rs.getString("reviewMemo"));
			map.put("customerId", rs.getString("customerId"));
			map.put("createdate", rs.getString("createdate"));
			reviewList.add(map);
		}
		rs.close();
		stmt.close();
		return reviewList;
	}
	
	// 2) 사원
	// 2-1) 본인이 등록한 상품의 리뷰만 조회(사원 레벨 1,2) : 마이페이지 - 리뷰목록(본인이 등록한 상품에 대한 리뷰만)
	public ArrayList<HashMap<String, Object>> selectReviewByEmpID(Connection conn, String empId) throws Exception{
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT o.order_code orderCode"
				+ ", g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", r.review_memo reviewMemo"
				+ ", o.customer_id customerId"
				+ ", o.order_state orderState"
				+ ", r.createdate createdate"
				+ " FROM review r INNER JOIN orders o"
				+ "	ON r.order_code = o.order_code"
				+ "		INNER JOIN goods g"
				+ "		ON g.goods_code = o.goods_code"
				+ " WHERE g.emp_id = ?"
				+ " ORDER BY r.createdate DESC";;
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("goodsName", rs.getString("goodsName"));
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
	
	// 2-2) 모든 리뷰 조회(관리자) : 마이페이지 - 리뷰목록(모든 리뷰 목록)
	public ArrayList<HashMap<String, Object>> selectReviewAll(Connection conn) throws Exception{
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT o.order_code orderCode"
				+ ", g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", r.review_memo reviewMemo"
				+ ", o.customer_id customerId"
				+ ", o.order_state orderState"
				+ ", r.createdate createdate"
				+ " FROM review r INNER JOIN orders o"
				+ "	ON r.order_code = o.order_code"
				+ "		INNER JOIN goods g"
				+ "		ON g.goods_code = o.goods_code"
				+ " ORDER BY r.createdate DESC";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("orderCode", rs.getInt("orderCode"));
			map.put("goodsCode", rs.getInt("goodsCode"));
			map.put("goodsName", rs.getString("goodsName"));
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
