package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import vo.Outid;

public class OutidDao {
	public int insertOutid(Connection conn, Outid outid) throws Exception{
		int row = 0;
		
		String sql ="INSERT INTO outid(id, createdate) VALUES(?, CURDATE())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, outid.getId());
		
		row = stmt.executeUpdate();
		
		return row;
		
	}
}
