package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.NoticeService;
import vo.Emp;
import vo.Notice;


@WebServlet("/NoticeModify")
public class NoticeModify extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 파라메터 넘겨받기
		int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
		System.out.println("noticeCode: "+noticeCode);
		
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
			System.out.println("수정 권한 없음");
			response.sendRedirect(request.getContextPath()+"/NoticeOne?noticeCode="+noticeCode);
			return;
		}
		
		// 서비스 호출(수정할 데이터 select : 공지 상세보기 메서드)
		NoticeService noticeService = new NoticeService();
		Notice notice = noticeService.getNoticeOne(noticeCode);
		
		// 세션에 저장
		request.setAttribute("notice", notice);
		
		// view 호출
		request.getRequestDispatcher("/WEB-INF/view/notice/modifyNotice.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션정보 확인(비로그인, 로그인, 회원, 사원)
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		// 파라메터 넘겨받기
		request.setCharacterEncoding("utf-8");
		int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
		String noticeTitle = request.getParameter("noticeTitle");
		String noticeContent = request.getParameter("noticeContent");
		
		// 데이터 묶기
		Notice paramNotice = new Notice();
		paramNotice.setNoticeCode(noticeCode);
		paramNotice.setNoticeTitle(noticeTitle);
		paramNotice.setNoticeContent(noticeContent);
		
		// 서비스 호출
		NoticeService noticeService = new NoticeService();
		int row = noticeService.modifyNotice(paramNotice);
		if(row == 0) {
			System.out.println("수정 실패");
			response.sendRedirect(request.getContextPath()+"/NoticeModify");
			return;
		}
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/NoticeList");
	}

}
