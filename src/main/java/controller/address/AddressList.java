package controller.address;

import java.io.IOException;
import java.util.ArrayList;

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


@WebServlet("/AddressList")
public class AddressList extends HttpServlet {
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
		
		// 세션에 저장된 회원 아이디 호출
		Customer customer = (Customer)session.getAttribute("loginMember");
		String customerId = customer.getCustomerId();
		
		// 서비스 호출
		this.customerAddressService = new CustomerAddressService();
		ArrayList<CustomerAddress> addressList = customerAddressService.getAddressByCustomerId(customerId);
		
		// 세션 저장
		request.setAttribute("addressList", addressList);
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/address/addressList.jsp").forward(request, response);
	}

}
