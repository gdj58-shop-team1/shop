package controller.address;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CustomerAddressService;
import vo.Customer;
import vo.CustomerAddress;
import vo.Emp;


@WebServlet("/AddAddress")
public class AddAddress extends HttpServlet {
	private CustomerAddressService customerAddressService;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 세션 유효성 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		// 세션에 담긴 정보 확인(회원, 관리자)
		if(session.getAttribute("loginMember") instanceof Emp) { // 세션에 저장된 정보가 Emp 타입이면
			System.out.println("잘못된 접근: 관리자 접근 불가 페이지");
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/address/addAddress.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		// 세션에 담긴 정보 확인(회원, 관리자)
		if(session.getAttribute("loginMember") instanceof Emp) { // 세션에 저장된 정보가 Emp 타입이면
			System.out.println("잘못된 접근: 관리자 접근 불가 페이지");
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		// 세션에 저장된 회원 아이디 호출
		Customer customer = (Customer)session.getAttribute("loginMember");
		String customerId = customer.getCustomerId();
		// 파라메터 받아오기
		String address = request.getParameter("address");
		
		// 데이터 묶기
		CustomerAddress paramAddress = new CustomerAddress();
		paramAddress.setAddress(address);
		paramAddress.setCustomerId(customerId);
		
		// 서비스 호출
		this.customerAddressService = new CustomerAddressService();
		int row = customerAddressService.addAddress(paramAddress);
		if(row == 0) {
			System.out.println("주소 추가 실패");
		}
		System.out.println("주소 추가 성공");
		response.sendRedirect(request.getContextPath()+"/AddressList");
	}

}
