package controller.order;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CustomerAddressService;
import service.OrderService;
import vo.CustomerAddress;
import vo.Emp;
import vo.Orders;


@WebServlet("/AddOrderDirect")
public class AddOrderDirect extends HttpServlet {
	private OrderService orderService;
	private CustomerAddressService customerAddressService;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.orderService = new OrderService();
		this.customerAddressService = new CustomerAddressService();
		
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
		
		// 파라메터 넘겨 받기
		int addressCode = Integer.parseInt(request.getParameter("addressCode"));
		int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
		String customerId = request.getParameter("customerId");
		int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
		String goodsOption = request.getParameter("goodsOption");
		int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
		
		String newAddress = null; // 새 주소 작성 유무에 따라 아래 코드 실행
		if(request.getParameter("newAddress") != null) {
			newAddress = request.getParameter("newAddress");
			
			CustomerAddress paramAddress = new CustomerAddress();
			paramAddress.setAddress(newAddress);
			paramAddress.setCustomerId(customerId);
			
			// 새로운 주소 insert
			int row = customerAddressService.addAddress(paramAddress);
			if(row == 0) {
				System.out.println("주소 추가 실패");
				response.sendRedirect(request.getContextPath()+"/GoodsOne?goodsCode="+goodsCode);
				return;
			}
			System.out.println("주소 추가 성공");
			
			// 새로운 주소코드 select
			addressCode = customerAddressService.getAddressCode(customerId);
		}
		// System.out.println("newAddress: "+newAddress);
		// System.out.println("addressCode: "+addressCode);
		
		String goodsName = request.getParameter("goodsName"); // 세션에 따로 저장
		String fileName = request.getParameter("fileName"); // 세션에 따로 저장
		
		// 데이터 묶기
		Orders order = new Orders();
		order.setGoodsCode(goodsCode);
		order.setOrderCode(addressCode);
		order.setCustomerId(customerId);
		order.setOrderQuantity(orderQuantity);
		order.setGoodsOption(goodsOption);
		order.setOrderPrice(orderPrice);
		
		// 서비스 호출
		String address = customerAddressService.selectAddressByOrderCode(addressCode); // 주문한 주소 호촐
		int row = orderService.insertOrderDirect(order); // add주문
		if(row == 0) {
			System.out.println("주문 실패");
			response.sendRedirect(request.getContextPath()+"/GoodsOne?goodsCode="+goodsCode);
			return;
		}
		System.out.println("주문 성공");
		
		// 세션에 저장(뷰에서 보여줄 정보)
		request.setAttribute("goodsName", goodsName);
		request.setAttribute("goodsPrice", goodsPrice);
		request.setAttribute("fileName", fileName);
		request.setAttribute("order", order);
		request.setAttribute("customerId", customerId);
		request.setAttribute("address", address);
		
		// 뷰 호출
		request.getRequestDispatcher("WEB-INF/view/order/orderComplete.jsp").forward(request, response);
		
	}

}
