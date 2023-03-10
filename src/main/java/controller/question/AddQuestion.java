package controller.question;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.GoodsService;
import service.OrderService;
import service.QuestionService;
import vo.Customer;
import vo.Orders;
import vo.Question;

/**
 * Servlet implementation class AddQuestion
 */
@WebServlet("/AddQuestion")
public class AddQuestion extends HttpServlet {
	private QuestionService questionService;
	private OrderService orderService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		Customer loginCustomer = (Customer) session.getAttribute("loginMember");
		
		int orderCode = Integer.parseInt(request.getParameter("orderCode"));
		this.orderService = new OrderService();
		
		HashMap<String , Object> map = orderService.getOrderByOrderCode(orderCode);
		
		request.setAttribute("map", map);
		request.getRequestDispatcher("/WEB-INF/view/question/addQuestion.jsp").forward(request, response);
	}

	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		 int orderCode = Integer.parseInt(request.getParameter("orderCode"));
		 String category = request.getParameter("category");
		 String questionTitle = request.getParameter("questionTitle");
		 String questionMemo = request.getParameter("questionMemo");
		 
		 Question question = new Question();
		 question.setOrderCode(orderCode);
		 question.setCategory(category);
		 question.setQuestionTitle(questionTitle);
		 question.setQuestionMemo(questionMemo);
		 
		 this.questionService = new QuestionService();
		 int row = questionService.addQuestionForCustomer(question);
		 
		 if(row != 1) {
			 System.out.println("문의글 작성 실패");
			 response.sendRedirect(request.getContextPath()+"/AddQuestion");
			 return;
		 }
		 
		 System.out.println("문의글 작성 성공");
		 response.sendRedirect(request.getContextPath()+"/QuestionList");
	}

}
