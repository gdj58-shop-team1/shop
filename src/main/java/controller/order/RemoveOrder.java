package controller.order;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.OrderService;
import vo.Customer;


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
		// 세션의 로그인 정보 가져오기
		Customer loginCustomer = (Customer) session.getAttribute("loginMember");
		String customerId = loginCustomer.getCustomerId();
		
		// 파라메터 받기
		int orderCode = Integer.parseInt(request.getParameter("orderCode"));
		int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
		int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
		int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
		int point = (goodsPrice * orderQuantity) - orderPrice;
		String orderState = "주문취소";
		
		// 서비스 호출
		this.orderService = new OrderService();
		orderService.modifyOrderCancel(customerId, orderCode, orderState, point);

		response.sendRedirect(request.getContextPath()+"/OrderList");
	}

}
