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
import vo.Cart;
import vo.Customer;
import vo.CustomerAddress;
import vo.Emp;


@WebServlet("/GetOrderInfoFromCart")
public class GetOrderInfoFromCart extends HttpServlet {
	private CustomerAddressService customerAddressService;
	private CustomerService customerService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 세션 유효성 확인(관리자는 주문 페이지로 넘어가지 못하게 할지?)
		HttpSession session = request.getSession();
		System.out.println("장바구니 -> 주문하기");
		// 세션에 담긴 정보 확인(회원, 관리자)
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			System.out.println("비회원은 상품 구매 불가");
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		} else if(session.getAttribute("loginMember") instanceof Emp) { // 관리자 -> 관리자 계정으로는 구매불가 경고창
			System.out.println("관리자는 상품 구매 불가");
			response.sendRedirect(request.getContextPath()+"/CartList");
			return;
		}

		Customer loginCustomer = (Customer) session.getAttribute("loginMember");
		
		// 서비스 호출(회원정보+주소 불러오기)
		this.customerAddressService = new CustomerAddressService();
		this.customerService = new CustomerService();
		ArrayList<CustomerAddress> addressList = new ArrayList<CustomerAddress>();		
		addressList = customerAddressService.getAddressByCustomerId(loginCustomer.getCustomerId()); // 주소 리스트
		Customer customer = customerService.getCustomer(loginCustomer); // 회원 정보
		
		int totalPrice = 0;
		// 세션 속 cartList의 orderPrice 전부 더해 주기(총 합계 금액 산출)
		ArrayList<HashMap<String, Object>> cartList = (ArrayList<HashMap<String, Object>>) session.getAttribute("cartList");	
		for(int i=0 ; i<cartList.size() ; i++) {
			System.out.println("돌아라~");
			totalPrice = totalPrice + (int)cartList.get(i).get("orderPrice");
		}
		
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("addressList", addressList);
		request.setAttribute("customer", customer);
		
		// 주문 페이지로
		request.getRequestDispatcher("/WEB-INF/view/order/addOrderFromCart.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
	}
}
