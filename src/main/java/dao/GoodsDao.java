package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class GoodsDao {
	
	// 상품리스트(home) - 검색값X
	public ArrayList<HashMap<String, Object>> selectGoodsList(Connection conn, int beginRow, int endRow) throws Exception{
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		System.out.println("selectGoodsList(GoodsDao) 진입");
		
		String sql = "SELECT g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", g.goods_price goodsPrice"
				+ ", g.soldout soldout"
				+ ", img.filename filename"
				+ " FROM goods g INNER JOIN goods_img img"
				+ "	ON g.goods_code = img.goods_code"
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
			map.put("filename",rs.getString("filename"));
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
		
		System.out.println("selectGoodsList(GoodsDao) 진입");
		
		String sql = "SELECT g.goods_code goodsCode"
				+ ", g.goods_name goodsName"
				+ ", g.goods_price goodsPrice"
				+ ", g.soldout soldout"
				+ ", img.filename filename"
				+ " FROM goods g INNER JOIN goods_img img"
				+ "	ON g.goods_code = img.goods_code"
				+ " WHERE g.goods_name LIKE ?"
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
			map.put("filename",rs.getString("filename"));
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
}
