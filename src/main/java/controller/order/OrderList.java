package controller.order;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.OrderService;
import vo.Customer;
import vo.Emp;

@WebServlet("/OrderList")
public class OrderList extends HttpServlet {
	private OrderService orderService;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Customer loginCustomer = new Customer();
		Emp loginEmp = new Emp();
		this.orderService = new OrderService();
		
		// 세션 유효성 검사
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		// 세션에서 받아온 정보 구분 : 정보에 따라 서비스 분기
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String, Object>>();
		
		if(session.getAttribute("loginMember") instanceof Customer) { // 세션에 저장된 정보가 Customer 타입이면
			System.out.println("세션정보 : 회원");
			loginCustomer = (Customer)session.getAttribute("loginMember");
			String customerId = loginCustomer.getCustomerId();
			orderList = orderService.getOrderListById(customerId); // 서비스 호출

			
			for(int i=0; i<orderList.size(); i++) {
				int goodsPrice = (int)orderList.get(i).get("goodsPrice");
				
				if(orderList.get(i).get("goodsOption").equals("일반포장")) {
					orderList.get(i).put("goodsPrice", goodsPrice);
				} else if(orderList.get(i).get("goodsOption").equals("고급포장")) {
					orderList.get(i).put("goodsPrice", goodsPrice+2500);
				} else if(orderList.get(i).get("goodsOption").equals("보자기")) {
					orderList.get(i).put("goodsPrice", goodsPrice+5900);
				}
			}
			
			request.setAttribute("orderList", orderList);
			
		} else if (session.getAttribute("loginMember") instanceof Emp) {
			System.out.println("세션정보 : 관리자");
			loginEmp = (Emp)session.getAttribute("loginMember");
			orderList = orderService.getOrderListAll(); // 서비스 호출
			
			for(int i=0; i<orderList.size(); i++) {
				int goodsPrice = (int)orderList.get(i).get("goodsPrice");
				
				if(orderList.get(i).get("goodsOption").equals("일반포장")) {
					orderList.get(i).put("goodsPrice", goodsPrice);
				} else if(orderList.get(i).get("goodsOption").equals("고급포장")) {
					orderList.get(i).put("goodsPrice", goodsPrice+2500);
				} else if(orderList.get(i).get("goodsOption").equals("보자기")) {
					orderList.get(i).put("goodsPrice", goodsPrice+5900);
				}
			}
			
			request.setAttribute("orderList", orderList);
		}
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/order/orderList.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 검사
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		if(session.getAttribute("loginMember") instanceof Customer) {
			response.sendRedirect(request.getContextPath()+"/OrderList");
			System.out.println("잘못된 접근 : 관리자만 진입 가능");
			return;
		}
		
		// 파라메터 받기
		int orderCode = Integer.parseInt(request.getParameter("orderCode"));
		int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
		int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
		int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
		String orderState = request.getParameter("orderState");
		String customerId = request.getParameter("customerId");
		
		// point 계산
		int point = (goodsPrice * orderQuantity) - orderPrice;
		
		// 서비스 호출
		this.orderService = new OrderService();
		if(orderState.equals("주문취소")) {
			orderService.modifyOrderCancel(customerId, orderCode, orderState, point);
		} else {
			int row = orderService.modifyOrder(orderCode, orderState);
			if(row == 0) {
				System.out.println("주문상태 변경 실패");
			}
			System.out.println("주문상태 변경 성공");
		}

		response.sendRedirect(request.getContextPath()+"/OrderList");
	}	
}
