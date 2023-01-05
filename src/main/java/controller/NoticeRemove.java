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


@WebServlet("/NoticeRemove")
public class NoticeRemove extends HttpServlet {

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
			System.out.println("삭제 권한 없음");
			response.sendRedirect(request.getContextPath()+"/NoticeOne?noticeCode="+noticeCode);
			return;
		}
		
		// 서비스 호출
		NoticeService noticeService = new NoticeService();
		int row = noticeService.removeNotice(noticeCode);
		if(row == 0) {
			System.out.println("삭제 실패");
			response.sendRedirect(request.getContextPath()+"/NoticeOneController?noticeCode="+noticeCode);
			return;
		}
		System.out.println("삭제 성공");
		response.sendRedirect(request.getContextPath()+"/NoticeList");
	}
}
