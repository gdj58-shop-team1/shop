package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.NoticeService;
import vo.Notice;

@WebServlet("/NoticeAdd")
public class NoticeAdd extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인 + 로그인 레벨 확인

		
		// view 호출
		request.getRequestDispatcher("/WEB-INF/view/notice/addNotice.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인 + 로그인 레벨 확인
		
		// 파라메터 넘겨받기
		request.setCharacterEncoding("utf-8");
		String noticeTitle = request.getParameter("noticeTitle");
		String noticeContent = request.getParameter("noticeContent");
		
		// 데이터 묶기
		Notice paramNotice = new Notice();
		paramNotice.setNoticeTitle(noticeTitle);
		paramNotice.setNoticeContent(noticeContent);
		paramNotice.setEmpId("test"); // 세션에서 얻은 관리자 아이디 포함
		
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
