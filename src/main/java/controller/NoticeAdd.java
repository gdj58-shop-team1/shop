package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.NoticeService;
import vo.Emp;
import vo.Notice;


@WebServlet("/NoticeAdd")
public class NoticeAdd extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션정보 확인(비로그인, 로그인, 회원, 사원) + 로그인 레벨 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		// 세션이 있다면 레벨 확인
		Emp loginEmp = (Emp)session.getAttribute("loginMember");
		int autoCode = loginEmp.getAuthCode();
		if(autoCode < 2) {
			System.out.println("작성 권한 없음");
			response.sendRedirect(request.getContextPath()+"/NoticeList");
			return;
		}
		
		// view 호출
		request.getRequestDispatcher("/WEB-INF/view/notice/addNotice.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션정보 확인(비로그인, 로그인, 회원, 사원) + 로그인 레벨 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		
		// 파라메터 넘겨받기
		request.setCharacterEncoding("utf-8");
		String noticeTitle = request.getParameter("noticeTitle");
		String noticeContent = request.getParameter("noticeContent");
		
		// 데이터 묶기
		Emp loginEmp = (Emp)session.getAttribute("loginMember"); // 세션에서 얻은 관리자 아이디 포함
		String empId= loginEmp.getEmpId();
		
		Notice paramNotice = new Notice();
		paramNotice.setNoticeTitle(noticeTitle);
		paramNotice.setNoticeContent(noticeContent);
		paramNotice.setEmpId(empId); 
		
		
		// 서비스 호출
		NoticeService noticeService = new NoticeService();
		int row = noticeService.addNotice(paramNotice);
		if(row == 0) {
			System.out.println("추가 실패");
			response.sendRedirect(request.getContextPath()+"/NoticeModify");
			return;
		}
		System.out.println("추가 성공");
		response.sendRedirect(request.getContextPath()+"/NoticeList");
	}

}
