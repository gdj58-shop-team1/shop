package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.PointHistory;

public class PointHistoryDao {

	// 포인트 내역 조회(select)
	public ArrayList<PointHistory> selectPointHistoryList(Connection conn, String customerId) throws Exception{
		ArrayList<PointHistory> pointList = new ArrayList<PointHistory>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ "	, po.point_kind pointKind"
				+ "	, po.point point"
				+ "	, po.createdate createdate"
				+ " FROM orders o INNER JOIN point_history po"
				+ "		ON o.order_code = po.order_code"
				+ " WHERE o.customer_id = ?"
				+ " ORDER BY po.createdate DESC";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		rs = stmt.executeQuery();
		while(rs.next()) {
			PointHistory p = new PointHistory();
			p.setPoint(rs.getInt("point"));
			p.setPointKind(rs.getString("pointKind"));
			p.setCreatedate(rs.getString("createdate"));
			pointList.add(p);
		}
		rs.close();
		stmt.close();
		return pointList;
	}
	
	// 포인트 적립/사용(insert)
	public int insertPoint(Connection conn, PointHistory paramPoint) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INRO point_history (order_code, point_kind, point) VALUES (?, ?, ?)";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramPoint.getOrderCode());
		stmt.setString(2, paramPoint.getPointKind());
		stmt.setInt(3, paramPoint.getPoint());
		row = stmt.executeUpdate();
		 
		stmt.close();
		return row;
	}
	
}
