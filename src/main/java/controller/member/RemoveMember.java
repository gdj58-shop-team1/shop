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


@WebServlet("/RemoveMember")
public class RemoveMember extends HttpServlet {
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
				
		request.getRequestDispatcher("//WEB-INF/view/member/removeMember.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int row = 0;
		Customer loginCustomer = null;
		Emp loginEmp = null;
		
		this.customerService = new CustomerService();
		this.empService = new EmpService();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") instanceof Customer) { // customer 로그인 시,
			loginCustomer = (Customer)session.getAttribute("loginMember");
			String customerPw = request.getParameter("customerPw");
			
			loginCustomer.setCustomerPw(customerPw);
			
			this.customerService = new CustomerService();
			row = customerService.removeCustomer(loginCustomer);
			
			if(row != 1) { // 회원정보 수정 및 세션에 재입력 실패 시,
				response.sendRedirect(request.getContextPath()+"/RemoveMember");
				return;
			}
			
					
		} else if(session.getAttribute("loginMember") instanceof Emp) { // emp 로그인 시,
			loginEmp = (Emp)session.getAttribute("loginMember");
			String empPw = request.getParameter("empPw");
			
			loginEmp.setEmpPw(empPw);
			System.out.println(loginEmp.getEmpId());
			System.out.println(loginEmp.getEmpId());
			this.empService = new EmpService();
			row = empService.removeEmp(loginEmp);
			
			if(row != 1) { // 회원정보 수정 및 세션에 재입력 실패 시,
				response.sendRedirect(request.getContextPath()+"/RemoveMember");
				return;
			}

		}
		
		response.sendRedirect(request.getContextPath()+"/Logout");
	}

}
