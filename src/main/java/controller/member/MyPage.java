package controller.member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class MyPage
 */
@WebServlet("/MyPage")
public class MyPage extends HttpServlet {
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") != null) { // 로그인되어있을 때 세션에 로그인정보 세팅
			request.setAttribute("loginMember", session.getAttribute("loginMember"));
			request.getRequestDispatcher("/WEB-INF/view/myPage.jsp").forward(request, response);
		} else { // 로그인되어 있지 않을 때 (login 컨트롤러 실행)
			response.sendRedirect(request.getContextPath()+"/Login");
		}
	}
}
