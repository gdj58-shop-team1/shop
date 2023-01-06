package controller;

import java.io.IOException;
import java.net.URLEncoder;

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
 * Servlet implementation class LoginController
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private CustomerService customerService;
	private EmpService empService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 로그인 전에만 접근가능
		HttpSession session = request.getSession();
		
		// 로그인 여부확인, 로그인 되어있을 경우 회원페이지로 이동	
		if(session.getAttribute("loginMember") != null) {

			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
				
		request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Customer loginCustomer = null;
		Emp loginEmp = null;
		
		HttpSession session = request.getSession();
		
		if(request.getParameter("customerId") != null && request.getParameter("customerPw") != null) { // customer 로그인
			Customer customer = new Customer();
			customer.setCustomerId(request.getParameter("customerId"));
			customer.setCustomerPw(request.getParameter("customerPw"));
			
			this.customerService = new CustomerService();
			loginCustomer = customerService.loginCustomer(customer);
			
			session.setAttribute("loginMember", loginCustomer);
		} else { // emp 로그인
			Emp emp = new Emp();
			System.out.println(request.getParameter("empId"));
			System.out.println(request.getParameter("empPw"));
			emp.setEmpId(request.getParameter("empId"));
			emp.setEmpPw(request.getParameter("empPw"));
			
			this.empService = new EmpService();
			loginEmp = empService.loginEmp(emp);
			
			session.setAttribute("loginMember", loginEmp);
		}

		String message = null;
		
		if(loginCustomer == null && loginEmp == null) {
			message = "로그인 실패";
			message = URLEncoder.encode(message, "UTF-8");
			response.sendRedirect(request.getContextPath()+"/Login?message="+message);
			return;
		}
		
		message = "로그인 성공!";
		message = URLEncoder.encode(message, "UTF-8");
		response.sendRedirect(request.getContextPath()+"/Home?message="+message);
	}

}
