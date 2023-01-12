package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import vo.GoodsImg;

public class GoodsImgDao {
	
	// 상품 추가하기
	public int insertGoodsImg(Connection conn, GoodsImg goodsImg, int autoKey) throws Exception { 
		PreparedStatement stmt = null;
		int result = 0;
		
			
			String sql = "INSERT INTO goods_img(goods_code, filename, origin_name, content_type, createdate) VALUES(?, ?, ?, ? ,NOW())";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, autoKey);
			stmt.setString(2, goodsImg.getFileName());
			stmt.setString(3, goodsImg.getOriginName());
			stmt.setString(4, goodsImg.getContentType());
			result = stmt.executeUpdate();
			
			if(stmt != null) {stmt.close();}	
			return result;
	
		
	}

}
