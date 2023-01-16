package controller.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.OrderService;


@WebServlet("/RemoveOrder")
public class RemoveOrder extends HttpServlet {
	private OrderService orderService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 검사
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		// 파라메터 받기
		int orderCode = Integer.parseInt(request.getParameter("orderCode"));
		String orderState = "주문취소";
		
		// 서비스 호출
		this.orderService = new OrderService();
		int row = orderService.modifyOrder(orderCode, orderState);
		if(row == 0) {
			System.out.println("주문상태 변경 실패");
		}
		System.out.println("주문상태 변경 성공");
		response.sendRedirect(request.getContextPath()+"/OrderList");
	}

}
