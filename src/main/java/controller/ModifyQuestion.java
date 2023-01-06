package controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.QuestionService;
import vo.Question;


@WebServlet("/ModifyQuestion")
public class ModifyQuestion extends HttpServlet {
	private QuestionService questionService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		// 기존값 세팅
		int questionCode = Integer.parseInt(request.getParameter("questionCode"));
		
		Question question = new Question();
		question.setQuestionCode(questionCode);
		
		questionService = new QuestionService();
		HashMap<String, Object> map = questionService.getQuestionOne(question);
		
		request.setAttribute("question", map);
		request.getRequestDispatcher("/WEB-INF/view/question/modifyQuestion.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 request.setCharacterEncoding("UTF-8");
		 
		 System.out.println(request.getParameter("questionCode"));
		 int questionCode = Integer.parseInt(request.getParameter("questionCode"));
		 String category = request.getParameter("category");
		 String questionTitle = request.getParameter("questionTitle");
		 String questionMemo = request.getParameter("questionMemo");
		 
		 Question question = new Question();
		 question.setQuestionCode(questionCode);
		 question.setCategory(category);
		 question.setQuestionTitle(questionTitle);
		 question.setQuestionMemo(questionMemo);
		 
		 int row = questionService.modifyQuestionForCustomer(question);
		 
		 if(row != 1) {
			 System.out.println("문의글 수정 실패");
			 response.sendRedirect(request.getContextPath()+"/ModifyQuestion");
			 return;
		 }
		 
		 System.out.println("문의글 수정 성공");
		 response.sendRedirect(request.getContextPath()+"/QuestionOne?questionCode="+questionCode);
	}

}
