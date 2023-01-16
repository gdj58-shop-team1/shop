package controller.question;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.QuestionCommentDao;
import service.QuestionCommentService;
import service.QuestionService;
import vo.Question;
import vo.QuestionComment;


@WebServlet("/QuestionOne")
public class QuestionOne extends HttpServlet {
	private QuestionService questionService;
	private QuestionCommentService questionCommentService;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		int questionCode = Integer.parseInt(request.getParameter("questionCode"));
		
		Question question = new Question();
		question.setQuestionCode(questionCode);
		
		QuestionComment questionComment = new QuestionComment();
		questionComment.setQuestionCode(questionCode);
		
		questionService = new QuestionService();
		HashMap<String, Object> map = questionService.getQuestionOne(question);
		
		questionCommentService = new QuestionCommentService();
		ArrayList<QuestionComment> list = questionCommentService.getQuestionCommentList(questionComment);
		
		request.setAttribute("question", map);
		request.setAttribute("list", list);
		request.getRequestDispatcher("/WEB-INF/view/question/questionOne.jsp").forward(request, response);
	}

}
