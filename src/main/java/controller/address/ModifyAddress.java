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


@WebServlet("/ModifyAddress")
public class ModifyAddress extends HttpServlet {
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
		
		// 파라메터 받아오기
		int addressCode = Integer.parseInt(request.getParameter("addressCode"));
		
		// 서비스 호출(수정할 주소 정보 가져오기)
		this.customerAddressService = new CustomerAddressService();
		String address = customerAddressService.getAddressByAddressCode(addressCode);
		
		// 세션에 저장
		request.setAttribute("addressCode", addressCode);
		request.setAttribute("address", address);
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/address/modifyAddress.jsp").forward(request, response);
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
		
		// 파라메터 받아오기
		String address = request.getParameter("address");
		int addressCode = Integer.parseInt(request.getParameter("addressCode"));
		
		// 데이터 묶기
		CustomerAddress paramAddress = new CustomerAddress();
		paramAddress.setAddress(address);
		paramAddress.setAddressCode(addressCode);
		
		// 서비스 호출
		this.customerAddressService = new CustomerAddressService();
		int row = customerAddressService.modifyAddress(paramAddress);
		if(row == 0) {
			System.out.println("주소 수정 실패");
			response.sendRedirect(request.getContextPath()+"/ModifyAddress?addressCode="+addressCode);
			return;
		}
		System.out.println("주소 수정 성공");
		response.sendRedirect(request.getContextPath()+"/AddressList");
	}

}
