package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.NoticeService;
import vo.Notice;


@WebServlet("/NoticeOne")
public class NoticeOne extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 세션 유효성 확인 + 로그인 레벨 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 세션에 로그인 정보다 없으면 홈으로
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		
		// 서비스 호출
		NoticeService noticeService = new NoticeService();
		int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
		System.out.println("noticeCode: "+noticeCode);
		
		Notice notice = noticeService.getNoticeOne(noticeCode);
		
		// 세션에 저장(사원 레벨도 세션에 저장 -> 뷰에서 레벨별 수정 삭제 버튼 보이게)
		request.setAttribute("notice", notice);
		
		// view 호출
		request.getRequestDispatcher("/WEB-INF/view/notice/noticeOne.jsp").forward(request, response);
		
	}

}
