package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LogoutController")
public class LogoutController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().invalidate();

		String message = "로그아웃 성공!";
		System.out.println(message);
		message = URLEncoder.encode(message, "UTF-8");
		response.sendRedirect(request.getContextPath()+"/HomeController?message="+message);
	}
}
