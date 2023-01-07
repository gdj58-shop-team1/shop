package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.Notice;

public class NoticeDao {
	
	// 공지 출력
	public ArrayList<Notice> selectNoticeList(Connection conn) throws Exception{
		ArrayList<Notice> noticeList = new ArrayList<Notice>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT notice_code noticeCode"
				+ ", notice_title noticeTitle"
				+ ", emp_id empId"
				+ ", createdate"
				+ " FROM notice"
				+ " ORDER BY notice_code DESC";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeCode(rs.getInt("noticeCode"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setEmpId(rs.getString("empId"));
			n.setCreatedate(rs.getString("createdate"));
			noticeList.add(n);
		}
		
		rs.close();
		stmt.close();
		return noticeList;
	}
	
	// 공지 상세보기
	public Notice selectNoticeOne(Connection conn, int noticeCode) throws Exception{
		Notice notice = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT notice_code noticeCode"
				+ ", notice_title noticeTitle"
				+ ", notice_content noticeContent"
				+ ", emp_id empId"
				+ ", createdate"
				+ " FROM notice"
				+ " WHERE notice_code = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeCode);
		rs = stmt.executeQuery();
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeCode(rs.getInt("noticeCode"));
			notice.setNoticeTitle(rs.getString("noticeTitle"));
			notice.setNoticeContent(rs.getString("noticeContent"));
			notice.setEmpId(rs.getString("empId"));
			notice.setCreatedate(rs.getString("createdate"));
		}
		
		rs.close();
		stmt.close();
		return notice;
	}
	
	// 공지 추가
	public int insertNotice(Connection conn, Notice paramNotice) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO notice (notice_title, notice_content, emp_id)"
				+ " VALUES (?, ?, ?)";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramNotice.getNoticeTitle());
		stmt.setString(2, paramNotice.getNoticeContent());
		stmt.setString(3, paramNotice.getEmpId());
		row = stmt.executeUpdate();
		
		stmt.close();
		return row; // 추가 성공 시 1 반환
	}
	
	// 공지 수정
	public int updateNotice(Connection conn, Notice paramNotice) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE notice SET notice_title = ?, notice_content = ?"
				+ " WHERE notice_code = ?";
		/*
			1) 글을 작성한 사원만 수정할 수 있는지? -> 관리자는 모두 수정 가능하게
			 -> 세션에서 일치하는지 확인 후 일치하면 수정 메서드 접근 가능하게 
			2) 사원 모두가 수정가능하게
		
		*/
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramNotice.getNoticeTitle());
		stmt.setString(2, paramNotice.getNoticeContent());
		stmt.setInt(3, paramNotice.getNoticeCode());
		row = stmt.executeUpdate();
		
		stmt.close();
		return row; // 수정 성공 시 1 반환
	}
	
	// 공지 삭제
	public int deleteNotice(Connection conn, int noticeCode) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM notice WHERE notice_code = ?";
		// 1) 글을 작성한 사원만 삭제할 수 있는지? -> 관리자는 모두 삭제 가능하게, 2) 사원 모두가 삭제가능하게
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeCode);
		row = stmt.executeUpdate();
		
		stmt.close();
		return row; // 삭제 성공 시 1 반환
	}
}
