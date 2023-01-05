package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.NoticeService;


@WebServlet("/NoticeRemove")
public class NoticeRemove extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 세션 유효성 확인 + 로그인 레벨 확인
		
		
		// 파라메터 넘겨받기
		int noticeCode = Integer.parseInt(request.getParameter("noticeCode"));
		System.out.println("noticeCode: "+noticeCode);
		
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
