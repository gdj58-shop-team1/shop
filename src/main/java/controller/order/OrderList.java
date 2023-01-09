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
		
		// 세션 유효성 검사
		Customer loginCustomer = new Customer();
		Emp loginEmp = new Emp();
		
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
		} else if (session.getAttribute("loginMember") instanceof Emp) {
			System.out.println("세션정보 : 관리자");
			loginEmp = (Emp)session.getAttribute("loginMember");
			orderList = orderService.getOrderListAll(); // 서비스 호출
		}
		
		// 세션에 리스트 저장
		request.setAttribute("orderList", orderList);
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/order/orderList.jsp").forward(request, response);
	}

}
