package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import vo.Customer;
import vo.Emp;
import vo.Question;

public class QuestionDao {
	
	// 1) 조회 (회원)
	public ArrayList<HashMap<String, Object>> selectQuestionForCustomer(Connection conn, Customer customer) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		String sql = "SELECT q.question_code questionCode"
				+ ", q.order_code orderCode"
				+ ", q.category category"
				+ ", q.question_title questionTitle"
				+ ", q.question_memo questionMemo"
				+ ", q.createdate createdate"
				+ ", g.goods_name goodsName"
				+ " FROM question q"
				+ "		INNER JOIN orders o"
				+ "		ON q.order_code = o.order_code"
				+ "		INNER JOIN goods g"
				+ "		ON o.goods_code = g.goods_code"
				+ " WHERE o.customer_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customer.getCustomerId());
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("questionCode", rs.getInt("questionCode"));
			map.put("orderCode", rs.getInt("questionCode"));
			map.put("category", rs.getString("category"));
			map.put("questionTitle", rs.getString("questionTitle"));
			map.put("questionMemo", rs.getString("questionMemo"));
			map.put("createdate", rs.getString("createdate"));	
			map.put("goodsName", rs.getString("goodsName"));
			list.add(map);
		}
		
		rs.close();
		stmt.close();
		return list;
	}
	
	// 2) 조회 (사원)
	public ArrayList<HashMap<String, Object>> selectQuestionForEmp(Connection conn, Emp emp) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		
		String sql = "SELECT q.question_code questionCode"
				+ ", q.order_code orderCode"
				+ ", q.category category"
				+ ", q.question_title questionTitle"
				+ ", q.question_memo questionMemo"
				+ ", q.createdate createdate"
				+ ", o.customer_id customerId"
				+ ", g.goods_name goodsName"
				+ " FROM question q"
				+ "		INNER JOIN orders o"
				+ "		ON q.order_code = o.order_code"
				+ "		INNER JOIN goods g"
				+ "		ON o.goods_code = g.goods_code"
				+ " WHERE g.emp_id = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, emp.getEmpId());
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("questionCode", rs.getInt("questionCode"));
			map.put("orderCode", rs.getInt("questionCode"));
			map.put("category", rs.getString("category"));
			map.put("questionTitle", rs.getString("questionTitle"));
			map.put("questionMemo", rs.getString("questionMemo"));
			map.put("createdate", rs.getString("createdate"));
			map.put("customerId", rs.getString("customerId"));
			map.put("goodsName", rs.getString("goodsName"));
			list.add(map);
		}
		rs.close();
		stmt.close();
		return list;
	}
	
	// 3) 문의 글 한개 가져오기
	public HashMap<String, Object> selectQuestionOne (Connection conn, Question question) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String sql = "SELECT q.question_code questionCode"
				+ ", q.order_code orderCode"
				+ ", q.category category"
				+ ", q.question_title questionTitle"
				+ ", q.question_memo questionMemo"
				+ ", q.createdate createdate"
				+ ", o.customer_id customerId"
				+ ", g.goods_name goodsName"
				+ " FROM question q"
				+ "		INNER JOIN orders o"
				+ "		ON q.order_code = o.order_code"
				+ "		INNER JOIN goods g"
				+ "		ON o.goods_code = g.goods_code"
				+ " WHERE q.question_code = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, question.getQuestionCode());
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			map.put("questionCode", rs.getInt("questionCode"));
			map.put("orderCode", rs.getInt("questionCode"));
			map.put("category", rs.getString("category"));
			map.put("questionTitle", rs.getString("questionTitle"));
			map.put("questionMemo", rs.getString("questionMemo"));
			map.put("createdate", rs.getString("createdate"));	
			map.put("customerId", rs.getString("customerId"));
			map.put("goodsName", rs.getString("goodsName"));
		}
		
		return map;
		
	}
	// 3) 문의 글 작성 (회원)
	public int insertQuestionForCustomer(Connection conn, Question question) throws Exception {
		int row = 0;
		System.out.println(question.getOrderCode());
		System.out.println(question.getCategory());
		System.out.println(question.getQuestionTitle());
		System.out.println(question.getQuestionMemo());
		
		String sql = "INSERT INTO"
				+ " question (order_code, category, question_title, question_memo)"
				+ " VALUES (?, ?, ?, ?)";
		
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setInt(1, question.getOrderCode());
		stmt.setString(2, question.getCategory());
		stmt.setString(3, question.getQuestionTitle());
		stmt.setString(4, question.getQuestionMemo());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;
	}
	
	// 4) 문의 글 수정 (회원)
	public int updateQuestionForCustomer(Connection conn, Question question) throws Exception {
		int row = 0;
		
		String sql = "UPDATE question"
				+ " SET category = ?, question_title = ?, question_memo = ?"
				+ " WHERE question_code = ?";
		
		PreparedStatement stmt= conn.prepareStatement(sql);		
		stmt.setString(1, question.getCategory());
		stmt.setString(2, question.getQuestionTitle());
		stmt.setString(3, question.getQuestionMemo());
		stmt.setInt(4, question.getQuestionCode());
		
		row = stmt.executeUpdate();
		
		stmt.close();
		return row;
	}
}
