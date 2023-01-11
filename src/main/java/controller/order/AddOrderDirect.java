package controller.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/AddOrderDirect")
public class AddOrderDirect extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		// 파라메터 받기
		int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
		String fileName = request.getParameter("fileName");
		String customerId = request.getParameter("customerId");
		int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
		String goodsOption = request.getParameter("goodsOption");
		int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
		
		String goodsName = request.getParameter("goodsName");
		
		// 서비스 호출(사용자 정보 불러오기)
		
		// 파라메터(주문정보), 호출 데이터(사용자 정보) 세션에 저장
		
		// 뷰 호출
	}

}
