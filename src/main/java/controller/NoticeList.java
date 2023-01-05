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

@WebServlet("/NoticeList")
public class NoticeList extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인 + 로그인 레벨 확인
		
		// 서비스 호출
		NoticeService noticeService = new NoticeService();
		ArrayList<Notice> noticeList = noticeService.getNoticeList();
		
		request.setAttribute("noticeList", noticeList);
		
		// view 호출
		request.getRequestDispatcher("/WEB-INF/view/notice/noticeList.jsp").forward(request, response);
	}

}
