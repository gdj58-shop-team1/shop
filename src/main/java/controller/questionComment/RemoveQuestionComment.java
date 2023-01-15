package controller.questionComment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.QuestionCommentService;
import vo.QuestionComment;

/**
 * Servlet implementation class RemoveQuestionComment
 */
@WebServlet("/RemoveQuestionComment")
public class RemoveQuestionComment extends HttpServlet {
	private QuestionCommentService questionService;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		int questionCode = Integer.parseInt(request.getParameter("questionCode"));
		int commentCode = Integer.parseInt(request.getParameter("commentCode"));
		
		QuestionComment questionComment = new QuestionComment();
		questionComment.setCommentCode(commentCode);
		
		this.questionService = new QuestionCommentService();
		questionService.removeQuestionComment(questionComment);
		
		response.sendRedirect(request.getContextPath()+"/QuestionOne?questionCode="+questionCode);
	}
}
