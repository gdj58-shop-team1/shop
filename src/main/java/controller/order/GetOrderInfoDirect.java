package controller.order;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CustomerAddressService;
import service.CustomerService;
import vo.Customer;
import vo.CustomerAddress;
import vo.Emp;
import vo.Orders;


@WebServlet("/GetOrderInfoDirect")
public class GetOrderInfoDirect extends HttpServlet {
	private CustomerAddressService customerAddressService;
	private CustomerService customerService;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
		
		// 세션에 담긴 정보 확인(회원, 관리자)
		if(session.getAttribute("loginMember") instanceof Emp) { // 세션에 저장된 정보가 Emp 타입이면
			System.out.println("관리자는 상품 구매 불가");
			response.sendRedirect(request.getContextPath()+"/GoodsOne?goodsCode="+goodsCode);
			return;
		}
		
		// 파라메터 받기
		// int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
		String customerId = request.getParameter("customerId");
		int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
		String goodsOption = request.getParameter("goodsOption");
		int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
		
		String goodsName = request.getParameter("goodsName"); // 세션에 따로 저장
		String fileName = request.getParameter("fileName"); // 세션에 따로 저장
		
		// 파라메터 묶기
		Orders order = new Orders();
		order.setGoodsCode(goodsCode);
		order.setCustomerId(customerId);
		order.setOrderQuantity(orderQuantity);
		order.setGoodsOption(goodsOption);
		order.setOrderPrice(orderPrice);
		
		Customer paramCustomer = new Customer();
		paramCustomer.setCustomerId(customerId);
		
		// 서비스 호출(회원정보+주소 불러오기)
		this.customerAddressService = new CustomerAddressService();
		this.customerService = new CustomerService();
		ArrayList<CustomerAddress> addressList = new ArrayList<CustomerAddress>();
		
		addressList = customerAddressService.getAddressByCustomerId(customerId); // 주소 리스트
		Customer customer = customerService.getCustomer(paramCustomer); // 회원 정보
		
		// 파라메터(주문정보), 호출 데이터(사용자 정보) 세션에 저장
		session.setAttribute("goodsName", goodsName);
		// session.setAttribute("goodsPrice", goodsPrice);
		session.setAttribute("orderPrice", orderPrice);
		session.setAttribute("fileName", fileName);
		session.setAttribute("order", order); // Orders type
		session.setAttribute("customer", customer); // Customer type
		request.setAttribute("addressList", addressList);
		request.setAttribute("goodsCode", goodsCode);
		
		// 주문 페이지로
		request.getRequestDispatcher("/WEB-INF/view/order/addOrderDirect.jsp").forward(request, response);
	}

}
