package controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CustomerDao;
import service.CustomerService;
import service.EmpService;
import vo.Customer;
import vo.Emp;


@WebServlet("/Signin")
public class Signin extends HttpServlet {
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
				
		request.getRequestDispatcher("/WEB-INF/view/signin.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int row = 0;
		
		HttpSession session = request.getSession();
		
		if(request.getParameter("customerId") != null && request.getParameter("customerPw") != null) { // customer 회원가입
			
			Customer customer = new Customer();
			customer.setCustomerId(request.getParameter("customerId"));
			customer.setCustomerPw(request.getParameter("customerPw"));
			customer.setCustomerName(request.getParameter("customerName"));
			customer.setCustomerPhone(request.getParameter("customerPhone"));
			
			this.customerService = new CustomerService();
			row = customerService.addCustomer(customer);
			
		} else { // emp 로그인
			Emp emp = new Emp();
			System.out.println(request.getParameter("empId"));
			System.out.println(request.getParameter("empPw"));
			emp.setEmpId(request.getParameter("empId"));
			emp.setEmpPw(request.getParameter("empPw"));
			emp.setEmpName(request.getParameter("empName"));
			
			this.empService = new EmpService();
			row = empService.addEmp(emp);
			
		}
		
		if(row != 1) {
			System.out.println("회원가입 실패!");
			response.sendRedirect(request.getContextPath()+"/Signin");
			return;
		} 
		
		System.out.println("회원가입 성공!");
		response.sendRedirect(request.getContextPath()+"/Login");	
		
		
	}

}
