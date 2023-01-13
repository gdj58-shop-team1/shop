package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Emp;
import vo.Goods;

public class GoodsDao {
	
	// 상품리스트(home) - 검색, 정렬값X
	public ArrayList<HashMap<String, Object>> selectGoodsList(Connection conn, int beginRow, int endRow) throws Exception{
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// System.out.println("selectGoodsList(GoodsDao) 검색, 정렬값X 진입");
		
		String sql = "SELECT g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", g.goods_price goodsPrice"
				+ ", g.soldout soldout"
				+ ", img.filename fileName"
				+ " FROM goods g INNER JOIN goods_img img"
				+ "	ON g.goods_code = img.goods_code"
				+ " ORDER BY goodsCode ASC"
				+ " LIMIT ?, ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, endRow);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("goodsCode",rs.getInt("goodsCode"));
			map.put("goodsName",rs.getString("goodsName"));
			map.put("goodsPrice",rs.getInt("goodsPrice"));
			map.put("soldout",rs.getString("soldout"));
			map.put("fileName",rs.getString("fileName"));
			goodsList.add(map);
		}
		
		rs.close();
		stmt.close();
		return goodsList;
	}
	
	// 상품리스트(home) - 검색값O
	public ArrayList<HashMap<String, Object>> selectGoodsList(Connection conn, int beginRow, int endRow, String searchWord) throws Exception{
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// System.out.println("selectGoodsList(GoodsDao) 검색O 진입");
		
		String sql = "SELECT g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", g.goods_price goodsPrice"
				+ ", g.soldout soldout"
				+ ", img.filename fileName"
				+ " FROM goods g INNER JOIN goods_img img"
				+ "	ON g.goods_code = img.goods_code"
				+ " WHERE g.goods_name LIKE ?"
				+ " ORDER BY goodsCode ASC"
				+ " LIMIT ?, ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, endRow);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("goodsCode",rs.getInt("goodsCode"));
			map.put("goodsName",rs.getString("goodsName"));
			map.put("goodsPrice",rs.getInt("goodsPrice"));
			map.put("soldout",rs.getString("soldout"));
			map.put("fileName",rs.getString("fileName"));
			goodsList.add(map);
		}
		
		rs.close();
		stmt.close();
		return goodsList;
	}
	
	// 상품리스트(home) - 정렬값O
	public ArrayList<HashMap<String, Object>> selectGoodsListSort(Connection conn, int beginRow, int endRow, String sort) throws Exception{
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// System.out.println("selectGoodsList(GoodsDao) 정렬O 진입");
		
		String sql = "SELECT g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", g.goods_price goodsPrice"
				+ ", g.soldout soldout"
				+ ", img.filename fileName"
				+ " FROM goods g INNER JOIN goods_img img"
				+ "	ON g.goods_code = img.goods_code"
				+ " ORDER BY "+sort // 인기순 정렬 시 hit로 상위노출
				+ " LIMIT ?, ?";
		
		stmt = conn.prepareStatement(sql);		
		stmt.setInt(1, beginRow);
		stmt.setInt(2, endRow);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("goodsCode",rs.getInt("goodsCode"));
			map.put("goodsName",rs.getString("goodsName"));
			map.put("goodsPrice",rs.getInt("goodsPrice"));
			map.put("soldout",rs.getString("soldout"));
			map.put("fileName",rs.getString("fileName"));
			goodsList.add(map);
		}
		
		rs.close();
		stmt.close();
		return goodsList;
	}
	
	// 총 상품 갯수 - 검색값X
	public int selectGoodsListCnt(Connection conn) throws Exception{
		int cnt = 0;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// System.out.println("selectGoodsListCnt(GoodsDao) 진입");
		
		String sql = "SELECT COUNT(*) cnt FROM goods";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("cnt");
		}
		
		rs.close();
		stmt.close();
		return cnt;
	}
	
	// 총 상품 갯수 - 검색값O
	public int selectGoodsListCnt(Connection conn, String searchWord) throws Exception{
		int cnt = 0;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		// System.out.println("selectGoodsListCnt(GoodsDao) 검색O 진입");
		
		String sql = "SELECT COUNT(*) cnt FROM goods WHERE goods_name LIKE ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("cnt");
		}
		
		rs.close();
		stmt.close();
		return cnt;
	}
	
	// 상품 상세페이지
	public HashMap<String, Object> selectGoodsOne(Connection conn, int goodscode) throws Exception{
		HashMap<String, Object> goodsMap = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT g.goods_code goodsCode"
				+ "	, g.goods_name goodsName"
				+ "	, g.goods_price goodsPrice"
				+ "	, g.soldout soldout"
				+ " , img.filename fileName"
				+ "	 FROM goods g INNER JOIN goods_img img"
				+ "		ON g.goods_code = img.goods_code"
				+ "	 WHERE g.goods_code = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodscode);
		rs = stmt.executeQuery();
		if(rs.next()) {
			goodsMap = new HashMap<String, Object>();
			goodsMap.put("goodsCode", rs.getInt("goodsCode"));
			goodsMap.put("goodsName", rs.getString("goodsName"));
			goodsMap.put("goodsPrice", rs.getInt("goodsPrice"));
			goodsMap.put("soldout", rs.getString("soldout"));
			goodsMap.put("fileName", rs.getString("fileName"));
		}
		return goodsMap;
	}
	
	// admin) 상품 등록하기
	public HashMap<String, Integer> insertGoods(Connection conn, Goods goods) throws Exception {
		
		/*
		 * String sql = "INSERT INTO" +
		 * " goods (goods_name, goods_price, goods_category, soldout, emp_id, hit)" +
		 * " VALUES (?, ?, ?, ?, ?, ?)";
		 
		System.out.println("==" + goods.getGoodsName());
		System.out.println("==" + goods.getGoodsPrice());
		System.out.println("==" + goods.getGoodsCategory());
		System.out.println("==" + goods.getSoldout());
		System.out.println("==" + goods.getEmpId());
		*/
		
		String sql = "INSERT INTO goods(goods_name, goods_price, goods_category, soldout, emp_id, createdate) VALUES(?, ?, ?, ?, ?, NOW())";
		// Statement.RETURN_GENERATED_KEYS 옵션 -> 쿼리실행 후 생성된 auto_increment값을 ResultSet에 반환
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, goods.getGoodsName());
		stmt.setInt(2, goods.getGoodsPrice());
		stmt.setString(3, goods.getGoodsCategory());
		stmt.setString(4, goods.getSoldout());
		stmt.setString(5, goods.getEmpId());
		
		
		
		int result = stmt.executeUpdate();
		ResultSet rs = stmt.getGeneratedKeys(); 
		
		int autoKey = 0; 
		if(rs.next()) {
			autoKey = rs.getInt(1); // goods.goods_code AUTO_INCREMENT
		}
		
		HashMap<String, Integer> m = new HashMap<>();
		m.put("result", result);
		m.put("autoKey", autoKey);
		
		if(rs != null) {rs.close();}
		if(stmt != null) {stmt.close();}
		
		return m;
		
	}
	
	// admin) 상품 리스트 (정렬)
	public ArrayList<HashMap<String, Object>> selectGoodsListAdmin(Connection conn, Emp emp, int beginRow, int endRow) throws Exception{
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", g.goods_price goodsPrice"
				+ ", g.goods_category goodsCategory"
				+ ", g.soldout soldout"
				+ ", g.emp_id empId"
				+ ", g.hit hit"
				+ ", img.filename fileName"
				+ " FROM goods g INNER JOIN goods_img img"
				+ "	ON g.goods_code = img.goods_code"
				+ " WHERE g.emp_id = ? "
				+ " ORDER BY goodsCode DESC"
				+ " LIMIT ?, ?";
		
		
		stmt = conn.prepareStatement(sql);	
		stmt.setString(1, emp.getEmpId());
		stmt.setInt(2, beginRow);
		stmt.setInt(3, endRow);
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("goodsCode",rs.getInt("goodsCode"));
			map.put("goodsName",rs.getString("goodsName"));
			map.put("goodsPrice",rs.getInt("goodsPrice"));
			map.put("goodsCategory",rs.getString("goodsCategory"));
			map.put("soldout",rs.getString("soldout"));
			map.put("empId",rs.getString("empId"));
			map.put("hit",rs.getInt("hit"));
			map.put("fileName",rs.getString("fileName"));
			goodsList.add(map);
		}
		

		rs.close();
		stmt.close();
		return goodsList;
	}
	
	// admin) 상품 삭제
	public int deleteGoods(Connection conn, int goodsCode) throws Exception {
		String sql = "DELETE FROM goods WHERE goods_code = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goodsCode);
		int result = stmt.executeUpdate();
		
		if(stmt != null) {stmt.close();}
		
		return result;
	}
	
	
	
	// admin) 상품one 상세페이지
		public HashMap<String, Object> selectGoodsOneAdmin(Connection conn, int goodsCode) throws Exception{
			HashMap<String, Object> goodsMap = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			String sql = "SELECT g.goods_code goodsCode"
					+ "	, g.goods_name goodsName"
					+ "	, g.goods_price goodsPrice"
					+ " , g.goods_category goodsCategory"
					+ "	, g.soldout soldout"
					+ " , g.emp_id empId"
					+ " , img.filename fileName"
					+ "	 FROM goods g INNER JOIN goods_img img"
					+ "		ON g.goods_code = img.goods_code"
					+ "	 WHERE g.goods_code = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsCode);
			
		
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				
				goodsMap = new HashMap<String, Object>();
				goodsMap.put("goodsCode", rs.getInt("goodsCode"));
				goodsMap.put("goodsName", rs.getString("goodsName"));
				goodsMap.put("goodsPrice", rs.getInt("goodsPrice"));
				goodsMap.put("goodsCategory", rs.getString("goodsCategory"));
				goodsMap.put("soldout", rs.getString("soldout"));
				goodsMap.put("empId", rs.getString("empId"));
				goodsMap.put("fileName", rs.getString("fileName"));
			}
			return goodsMap;
		}

	
	// admin) 상품 수정
	public int updateGoods(Connection conn, Goods goods) throws Exception {
		int row = 0;
		
		String sql = "UPDATE goods SET"
				+ " goods_name = ?"
				+ ", goods_price = ?"
				+ ", goods_category = ?"
				+ ", soldout = ?"
				+ " WHERE goods_code = ?"
				+ " AND emp_id = ?";
		
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, goods.getGoodsName());
		stmt.setInt(2,  goods.getGoodsPrice());
		stmt.setString(3,  goods.getGoodsCategory());
		stmt.setString(4, goods.getSoldout());
		stmt.setInt(5, goods.getGoodsCode());
		stmt.setString(6, goods.getEmpId());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;

	}
	
	// owner 관리자 레벨 3 ) 상품리스트 
	public ArrayList<HashMap<String, Object>> selectGoodsListForAdmin3(Connection conn,  int beginRow, int endRow) throws Exception{
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", g.goods_price goodsPrice"
				+ ", g.goods_category goodsCategory"
				+ ", g.soldout soldout"
				+ ", g.emp_id empId"
				+ ", g.hit hit"
				+ ", img.filename fileName"
				+ " FROM goods g INNER JOIN goods_img img"
				+ "	ON g.goods_code = img.goods_code"
				+ " ORDER BY goodsCode DESC"
				+ " LIMIT ?, ?";
		
		
		stmt = conn.prepareStatement(sql);	
		stmt.setInt(1, beginRow);
		stmt.setInt(2, endRow);
		
		System.out.println("관리자레벨 3 상품리스트Dao");
		
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("goodsCode",rs.getInt("goodsCode"));
			map.put("goodsName",rs.getString("goodsName"));
			map.put("goodsPrice",rs.getInt("goodsPrice"));
			map.put("goodsCategory",rs.getString("goodsCategory"));
			map.put("soldout",rs.getString("soldout"));
			map.put("empId",rs.getString("empId"));
			map.put("hit",rs.getInt("hit"));
			map.put("fileName",rs.getString("fileName"));
			goodsList.add(map);
		}
		

		rs.close();
		stmt.close();
		return goodsList;
	}
	
	// owner 관리자 레벨 3 ) hit 수정
	
	public int updateGoodsForAdmin3(Connection conn, Goods goods) throws Exception {
		int row = 0;
		
		String sql = "UPDATE goods SET"
				+ " hit = ?"
				+ " WHERE goods_code = ?";
				
		
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, goods.getHit());
		stmt.setInt(2, goods.getGoodsCode());
		
		
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;

	}
	
	
}
