package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import vo.GoodsImg;

public class GoodsImgDao {
	public int insertGoods(Connection conn, GoodsImg goodsImg) throws Exception { 
		int row = 0;
		
		String sql = "INSERT INTO goods_img(goods_code, filename) VALUES(?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(row, row);
	}

}
