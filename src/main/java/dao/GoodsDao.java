package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

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
	
}
