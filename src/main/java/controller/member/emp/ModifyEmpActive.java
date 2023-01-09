package controller.member.emp;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.EmpService;
import vo.Emp;


@WebServlet("/ModifyEmpActive")
public class ModifyEmpActive extends HttpServlet {
	private EmpService empService;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int row = 0;
		
		Emp loginEmp = null; // 로그인한 관리자
		Emp emp = null; // 정보를 변경시킬 사원
		
		this.empService = new EmpService();
		
		HttpSession session = request.getSession();
		
		if(!(session.getAttribute("loginMember") instanceof Emp)) {
			System.out.println("회원은 접근 불가!");
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		loginEmp = (Emp)session.getAttribute("loginMember");
		
		if(loginEmp.getAuthCode() < 3) {
			System.out.println("현재 관리자 레벨로는 접근 불가!");
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		String empId = request.getParameter("empId");
		String active = request.getParameter("active");
		
		emp = new Emp();
		emp.setEmpId(empId);
		emp.setActive(active);
		
		row = empService.modifyEmpActive(emp);

		
		if(row != 1) {
			System.out.println("관리자 active 수정 실패");
		}
		
		response.sendRedirect(request.getContextPath()+"/EmpList");
	}

}
