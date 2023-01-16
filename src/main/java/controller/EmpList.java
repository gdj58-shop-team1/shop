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

import service.EmpService;
import vo.Emp;

/**
 * Servlet implementation class EmpList
 */
@WebServlet("/EmpList")
public class EmpList extends HttpServlet {
	private EmpService empService;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션정보 확인(비로그인, 로그인, 회원, 사원) + 로그인 레벨 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		// 세션이 있다면 레벨 확인 -> 레벨 3
		Emp loginEmp = (Emp)session.getAttribute("loginMember");
		int autoCode = loginEmp.getAuthCode();
		if(autoCode < 3) {
			System.out.println("최상위 관리자만 들어올 수 있습니다");
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}

		
		
		// 페이지
		int rowPerPage = 10; // 한 페이지 당 보여질 관리자 목록 수
		int cnt = 0; // 총 관리자 수
		int endPage = 0; // 마지막 페이지
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// String sort = request.getParameter("sort"); // 정렬값

		// service 호출
		empService = new EmpService();
		ArrayList<HashMap<String, Object>> empList = new ArrayList<HashMap<String, Object>>();
		EmpService empService = new EmpService();
		
		empList = empService.getEmpListForAdmin3(loginEmp, currentPage, rowPerPage);
		System.out.println("emp리스트 getID : " + empList.get(0).get("empId"));
		// 마지막 페이지 구하기
		cnt = empService.getEmpCnt();
		endPage = cnt/rowPerPage;
		if(cnt%rowPerPage != 0) {
			endPage++;
		}
		
		// 세션에 정보 넘기기
		request.setAttribute("empList", empList);
		request.setAttribute("endPage", endPage);
		// request.setAttribute("sort", sort);
		request.setAttribute("currentPage", currentPage);
		
		
		System.out.println(request.getParameter("currentPage"));		
				
				
		// view 호출
		request.getRequestDispatcher("/WEB-INF/view/empList.jsp").forward(request, response);
				
		
		
	
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		
		// 파라메터 넘겨받기
		int empCode = Integer.parseInt(request.getParameter("empCode"));
		String active = request.getParameter("active");
		System.out.println("authCode : " + request.getParameter("authCode"));
		int authCode = Integer.parseInt(request.getParameter("authCode"));
		
		System.out.println(request.getParameter("empCode"));
		
		
		// 데이터 정리
		Emp emp = new Emp();
		emp.setEmpCode(empCode);
		emp.setActive(active);
		emp.setAuthCode(authCode);
		
		// 서비스 호출
		
		EmpService empService = new EmpService();
		int result = empService.modifyEmpForAdmin3(emp);
		if(result == 0) {
			System.out.println("수정실패");
			response.sendRedirect(request.getContextPath()+"/EmpList");
			return;
		}
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/EmpList");
	
	}

}
