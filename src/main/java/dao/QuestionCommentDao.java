package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.text.html.HTMLDocument.HTMLReader.PreAction;

import vo.QuestionComment;

public class QuestionCommentDao {
	// 0) 답변 조회
	public ArrayList<QuestionComment> selectQuestionCommentList(Connection conn, QuestionComment questionComment) throws Exception {
		ArrayList<QuestionComment> list = new ArrayList<QuestionComment>();
		
		String sql = "SELECT comment_code, question_code, comment_memo, createdate"
				+ "	FROM question_comment"
				+ " WHERE question_code = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionComment.getQuestionCode());
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			QuestionComment qc = new QuestionComment();
			qc.setCommentCode(rs.getInt("comment_code"));
			qc.setQuestionCode(rs.getInt("question_code"));
			qc.setCommentMemo(rs.getString("comment_memo"));
			qc.setCreatedate(rs.getString("createdate"));
			list.add(qc);
		}
		return list;
		
	}
	
	// 1) 답변 작성(사원)
	public int insertQuestionCommentList(Connection conn, QuestionComment questionComment) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO"
				+ " question_comment(question_code, comment_memo)"
				+ " VALUES(?, ?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionComment.getQuestionCode());
		stmt.setString(2, questionComment.getCommentMemo());
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 2) 답변 삭제(사원)
	public int deleteQuestionCommentList(Connection conn, QuestionComment questionComment) throws Exception {
		int row = 0;
		
		String sql = "DELETE"
				+ " FROM question_comment"
				+ " WHERE comment_code = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, questionComment.getCommentCode());
		
		row = stmt.executeUpdate();
		
		return row;
	}
}
