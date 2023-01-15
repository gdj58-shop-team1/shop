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


@WebServlet("/AddQuestionComment")
public class AddQuestionComment extends HttpServlet {
	private QuestionCommentService questionService;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		int questionCode = Integer.parseInt(request.getParameter("questionCode"));
		String commentMemo = request.getParameter("commentMemo");
		
		QuestionComment questionComment = new QuestionComment();
		questionComment.setCommentMemo(commentMemo);
		questionComment.setQuestionCode(questionCode);
		
		this.questionService = new QuestionCommentService();
		questionService.addQuestionComment(questionComment);
		
		response.sendRedirect(request.getContextPath()+"/QuestionOne?questionCode="+questionCode);
	}

}
