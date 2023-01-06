package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.QuestionService;
import vo.Customer;
import vo.Emp;


@WebServlet("/QuestionList")
public class QuestionList extends HttpServlet {       
   private QuestionService questionService;
   
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   	this.questionService = new QuestionService();
	   	Customer loginCustomer = new Customer();
	   	Emp loginEmp = new Emp();
	   	
	   	// 세션정보 확인(비로그인, 로그인, 회원, 사원)
	   	HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
				
		ArrayList<HashMap<String, Object>> list = null;
		
		if(session.getAttribute("loginMember") instanceof Customer) { // customer 로그인 시,
			System.out.println("회원로그인");
			loginCustomer = (Customer)session.getAttribute("loginMember");
			list = questionService.getQuestionForCustomer(loginCustomer);			
		} else if(session.getAttribute("loginMember") instanceof Emp) { // emp 로그인 시,
			loginEmp = (Emp)session.getAttribute("loginMember");
			list = questionService.getQuestionForEmp(loginEmp);
		}
		
		request.setAttribute("questionList", list);
		request.getRequestDispatcher("/WEB-INF/view/question/questionList.jsp").forward(request, response);
   }
}
