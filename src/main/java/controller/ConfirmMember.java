package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CustomerService;
import service.EmpService;
import vo.Customer;
import vo.Emp;

/**
 * Servlet implementation class ConfirmMember
 */
@WebServlet("/ConfirmMember")
public class ConfirmMember extends HttpServlet {
	
	private CustomerService customerService;
	private EmpService empService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 로그인 후에만 접근가능
		HttpSession session = request.getSession();
		
		// 로그인 여부확인, 로그인 되어있을 경우 회원페이지로 이동	
		if(session.getAttribute("loginMember") == null) {

			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		request.getRequestDispatcher("/WEB-INF/view/confirmMember.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer loginCustomer = null;
		Emp loginEmp = null;
		
		this.customerService = new CustomerService();
		this.empService = new EmpService();
		
		HttpSession session = request.getSession();
		
		String pw = request.getParameter("pw");
		if(session.getAttribute("loginMember") instanceof Customer) { // customer 로그인 시,
			loginCustomer = (Customer)session.getAttribute("loginMember");
			loginCustomer.setCustomerPw(pw);
			
			this.customerService = new CustomerService();
			Customer resultCustomer = customerService.getCustomer(loginCustomer);
			
			if(resultCustomer == null) {
				response.sendRedirect(request.getContextPath()+"/ConfirmMember");
			}
			
		} else if(session.getAttribute("loginMember") instanceof Emp) { // emp 로그인 시,
			loginEmp = (Emp)session.getAttribute("loginMember");
			loginEmp.setEmpPw(pw);
			
			this.empService = new EmpService();
			Emp resultEmp = empService.getEmp(loginEmp);
			
			if(resultEmp == null) {
				response.sendRedirect(request.getContextPath()+"/ConfirmMember");
			}
		}
		
		response.sendRedirect(request.getContextPath()+"/SelectModify");
	}

}
