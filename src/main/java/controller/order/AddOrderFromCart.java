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

import service.CustomerAddressService;
import service.CustomerService;
import service.OrderService;
import service.PointHistoryService;
import vo.Customer;
import vo.CustomerAddress;
import vo.Emp;
import vo.Orders;
import vo.PointHistory;


@WebServlet("/AddOrderFromCart")
public class AddOrderFromCart extends HttpServlet {
	private OrderService orderService;
	private CustomerService customerService;
	private CustomerAddressService customerAddressService;
	private PointHistoryService pointHistoryService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		this.orderService = new OrderService();
		this.customerService = new CustomerService();
		this.customerAddressService = new CustomerAddressService();
		this.pointHistoryService = new PointHistoryService();
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		} else if(session.getAttribute("loginMember") instanceof Emp) {
			System.out.println("관리자는 상품 구매 불가");
			response.sendRedirect(request.getContextPath()+"/GetOrderInfoFromCart");
			return;
		}
		
		
		// 고객 정보
		Customer loginCustomer = (Customer) session.getAttribute("loginMember");
		Customer orderCustomer = customerService.getCustomer(loginCustomer);
		
		
		// 주소 정보 request.getParameter
		int addressCode = Integer.parseInt(request.getParameter("addressCode"));
		String newAddress = null; // 새 주소 작성 유무에 따라 아래 코드 실행
		if(request.getParameter("newAddress") != null && !request.getParameter("newAddress").equals("")) {
			newAddress = request.getParameter("newAddress");
			
			CustomerAddress paramAddress = new CustomerAddress(); // 주소 추가 메서드에 들어갈 매개변수
			paramAddress.setAddress(newAddress);
			paramAddress.setCustomerId(orderCustomer.getCustomerId());
			
			// 새로운 주소 insert
			int row = customerAddressService.addAddress(paramAddress);
			if(row == 0) {
				System.out.println("주소 추가 실패");
				response.sendRedirect(request.getContextPath()+"/GetOrderInfoFromCart");
				return;
			}
			System.out.println("주소 추가 성공");
			
			// 새로운 주소코드 select
			addressCode = customerAddressService.getAddressCode(orderCustomer.getCustomerId());
		}
		
		// 상품에 관한 배열 request.getParameter
		String[] fileNameArr =  request.getParameterValues("fileName"); // 수정 X
		String[] goodsCodeArr =  request.getParameterValues("goodsCode"); // 수정 X
		String[] goodsNameArr =  request.getParameterValues("goodsName"); // 수정 X
		String[] goodsPriceArr =  request.getParameterValues("goodsPrice"); // 가격 - 포인트 값 수정
		String[] goodsOptionArr =  request.getParameterValues("goodsOption"); // 수정 X
		String[] orderQuantityArr =  request.getParameterValues("orderQuantity"); // 수정 X
		
		// 상품에 관한 request.getParameter 후 int 형변환
		int shareUsePoint = Integer.parseInt(request.getParameter("shareUsePoint"));
		int remainderUsePoint = Integer.parseInt(request.getParameter("remainderUsePoint"));
		int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
		
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String,Object>>();
		for(int i = 0; i < goodsCodeArr.length; i++) {
			// DB내 order테이블에 insert하기 위해 값 세팅			
			Orders orders = new Orders();
			orders.setGoodsOption(goodsOptionArr[i]);
			orders.setGoodsCode(Integer.parseInt(goodsCodeArr[i]));
			orders.setCustomerId(orderCustomer.getCustomerId());
			orders.setAddressCode(addressCode);
			orders.setOrderQuantity(Integer.parseInt(orderQuantityArr[i]));
			orders.setOrderPrice(Integer.parseInt(goodsPriceArr[i]));
			orders.setOrderState("주문완료");
			
			// 주문 서비스로 들어갈때 해야할 것
			// 1) insert order
			// 2) insert point(customer)
			// 3) insert point_history
			if(i == 0) {
				
			}
			// order테이블에 insert
			int addOrderRow = orderService.addOrderDirect(orders);
			if(addOrderRow == 0) {
				System.out.println("주문 실패");
				response.sendRedirect(request.getContextPath()+"/GetOrderInfoFromCart");
				return;
			}
			
			// point테이블에 point 사용내역 insert
			PointHistory pointHistory = new PointHistory();
			pointHistory.setOrderCode(Integer.parseInt(goodsCodeArr[i]));
			pointHistory.setPoint(shareUsePoint);
			pointHistory.setPointKind("사용");
			// 다음 view로 보내기위해 ArrayListHashMap사용
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("fileName", fileNameArr[i]);
			map.put("goodsCode", goodsCodeArr[i]);
			map.put("goodsName", goodsNameArr[i]);
			map.put("goodsPrice", goodsPriceArr[i]);
			map.put("goodsOption", goodsOptionArr[i]);
			map.put("orderQuantity", orderQuantityArr[i]);
			map.put("shareUsePoint", shareUsePoint);
			map.put("remainderUsePoint", remainderUsePoint);
			orderList.add(map);
		}
		
		// 뷰로 넘기기
		request.setAttribute("", orderList);
		request.setAttribute("orderCustomer", orderCustomer);
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute(newAddress, goodsOptionArr);
		
	}
}
