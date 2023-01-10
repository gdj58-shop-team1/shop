package controller.member;

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
 * Servlet implementation class modifyMember
 */
@WebServlet("/ModifyMember")
public class ModifyMember extends HttpServlet {
	
	private CustomerService customerService;
	private EmpService empService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer loginCustomer = null;
		Emp loginEmp = null;
		
		// 로그인 후에만 접근가능
		HttpSession session = request.getSession();
		
		// 로그인 여부확인, 로그인 되어있을 경우 회원페이지로 이동	
		if(session.getAttribute("loginMember") == null) {

			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		if(session.getAttribute("loginMember") instanceof Customer) { // customer 로그인 시,
			loginCustomer = (Customer)session.getAttribute("loginMember");
			this.customerService = new CustomerService();
			loginCustomer = customerService.getCustomer(loginCustomer);
			request.setAttribute("loginMember", loginCustomer);
			
		} else if(session.getAttribute("loginMember") instanceof Emp) { // emp 로그인 시,
			loginEmp = (Emp)session.getAttribute("loginMember");
			this.empService = new EmpService();
			loginEmp = empService.getEmp(loginEmp);
			request.setAttribute("loginMember", loginEmp);
		}
		
		
		request.getRequestDispatcher("/WEB-INF/view/modifyMember.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Customer loginCustomer = null;
		Emp loginEmp = null;
		
		this.customerService = new CustomerService();
		this.empService = new EmpService();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") instanceof Customer) { // customer 로그인 시,
			loginCustomer = (Customer)session.getAttribute("loginMember");
			String customerName = request.getParameter("customerName");
			String customerPhone = request.getParameter("customerPhone");
			
			loginCustomer.setCustomerName(customerName);
			loginCustomer.setCustomerPhone(customerPhone);
			
			this.customerService = new CustomerService();
			loginCustomer = customerService.modifyCustomer(loginCustomer);
			
			if(loginCustomer == null) { // 회원정보 수정 및 세션에 재입력 실패 시,
				response.sendRedirect(request.getContextPath()+"/ModifyMember");
				return;
			}
			
			session.setAttribute("loginMember", loginCustomer);
					
		} else if(session.getAttribute("loginMember") instanceof Emp) { // emp 로그인 시,
			loginEmp = (Emp)session.getAttribute("loginMember");
			String empName = request.getParameter("empName");
			
			loginEmp.setEmpName(empName);
			
			this.empService = new EmpService();
			loginEmp = empService.modifyEmp(loginEmp);
			
			if(loginEmp == null) { // 회원정보 수정 및 세션에 재입력 실패 시,
				response.sendRedirect(request.getContextPath()+"/ModifyMember");
				return;
			}
			
			session.setAttribute("loginMember", loginEmp);
		}
		
		response.sendRedirect(request.getContextPath()+"/MyPage");
	}

}
