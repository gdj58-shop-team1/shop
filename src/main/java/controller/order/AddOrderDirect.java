package controller.order;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CustomerAddressService;
import service.OrderService;
import service.PointHistoryService;
import vo.CustomerAddress;
import vo.Emp;
import vo.Orders;
import vo.PointHistory;


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
		Orders paramOrder = (Orders)session.getAttribute("order"); // 세션에서 주문정보 받아오기
		String customerId = paramOrder.getCustomerId();
		int addressCode = Integer.parseInt(request.getParameter("addressCode"));
		int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
		int usedPoint = 0; // 포인트 사용했다면 값 받아오고, 주문 성공 후 포인트 처리
		if((request.getParameter("point") != null && !request.getParameter("point").equals("")) || usedPoint > 0 ) {
			usedPoint = Integer.parseInt(request.getParameter("point"));
		}
		System.out.println("usedPoint: "+usedPoint);
		
		String newAddress = null; // 새 주소 작성 유무에 따라 아래 코드 실행
		if(request.getParameter("newAddress") != null && !request.getParameter("newAddress").equals("")) {
			newAddress = request.getParameter("newAddress");
			
			CustomerAddress paramAddress = new CustomerAddress(); // 주소 추가 메서드에 들어갈 매개변수
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
		
		// 데이터 묶기
		Orders order = new Orders();
		order.setGoodsCode(goodsCode);
		order.setCustomerId(customerId);
		order.setOrderQuantity(paramOrder.getOrderQuantity());
		order.setGoodsOption(paramOrder.getGoodsOption());
		order.setAddressCode(addressCode);
		order.setOrderPrice(orderPrice);
		
		// order 서비스 호출(포인트 사용 유무에 따라 분기)
		int orderRow = 0; // 주문 입력 결과 반환 변수
		if(usedPoint > 0) { // 포인트 사용
			usedPoint = usedPoint*-1; // 음수로 db에 입력하기 위함
			orderRow = orderService.addOrderDirectWithPoint(order, customerId, usedPoint);
		} else { // 포인트 미사용
			orderRow = orderService.addOrderDirect(order);
		}
		
		if(orderRow == 0) {
			System.out.println("주문 실패");
			response.sendRedirect(request.getContextPath()+"/GoodsOne?goodsCode="+goodsCode);
			return;
		}
		System.out.println("주문 성공");
		
		
		// 세션에 저장(뷰에서 보여줄 정보)
		String address = customerAddressService.getAddressByAddressCode(addressCode); // 주문한 주소 호촐
		request.setAttribute("order", order);
		request.setAttribute("address", address);
		
		// 뷰 호출
		request.getRequestDispatcher("WEB-INF/view/order/orderComplete.jsp").forward(request, response);
		session.removeAttribute("goodsName");
		session.removeAttribute("goodsPrice");
		session.removeAttribute("fileName");
		session.removeAttribute("order");
		session.removeAttribute("customer");
		
		// 세션에 저장된 모든 값 확인
		Enumeration<String> attributes = request.getSession().getAttributeNames();
		while (attributes.hasMoreElements()) {
		    String attribute = (String) attributes.nextElement();
		    System.err.println(attribute+" : "+request.getSession().getAttribute(attribute));
		}
		System.out.println("세션 종료");
	}

}
