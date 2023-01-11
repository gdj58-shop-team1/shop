package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import vo.GoodsImg;

public class GoodsImgDao {
	
	// 상품 추가하기
	public int insertGoodsImg(Connection conn, ArrayList<GoodsImg> list) throws Exception { 
		PreparedStatement stmt = null;
		int result = 0;
		
		for(GoodsImg gi : list) {
		
			String sql = "INSERT INTO goods_img(goods_code, filename, origin_name, content_type, createdate) VALUES(?, ?, ?, ? ,NOW()";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, gi.getGoodsCode());
			stmt.setString(2, gi.getFileName());
			stmt.setString(3, gi.getOriginName());
			stmt.setString(4,  gi.getContentType());
			result = stmt.executeUpdate();
					
		}
		
		if(stmt != null) {stmt.close();}
		return result;
	}

}
