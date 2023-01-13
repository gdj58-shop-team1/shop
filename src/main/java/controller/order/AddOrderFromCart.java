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
import vo.Customer;
import vo.CustomerAddress;


@WebServlet("/AddOrderFromCart")
public class AddOrderFromCart extends HttpServlet {
	private CustomerService customerService;
	private CustomerAddressService customerAddressService;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 고객 정보
		Customer loginCustomer = (Customer) session.getAttribute("loginMember");
		Customer orderCustomer = customerService.getCustomer(loginCustomer);
		
		// 주소 정보 request.getParameter
		int addressCode = Integer.parseInt(request.getParameter("addressCode"));
		
		String newAddress = null; // 새 주소 작성 유무에 따라 아래 코드 실행
		if(request.getParameter("newAddress") != null) {
			newAddress = request.getParameter("newAddress");
			
			CustomerAddress paramAddress = new CustomerAddress();
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
		}
		
		// 상품에 관한 배열 request.getParameter
		String[] fileNameArr =  request.getParameterValues("fileName"); // 수정 X
		String[] goodsCodeArr =  request.getParameterValues("goodsCode"); // 수정 X
		String[] goodsNameArr =  request.getParameterValues("goodsName"); // 수정 X
		String[] goodsPriceArr =  request.getParameterValues("goodsPrice"); // 가격 - 포인트 값 수정
		String[] goodsOptionArr =  request.getParameterValues("goodsOption"); // 수정 X
		String[] orderQuantityArr =  request.getParameterValues("orderQuantity"); // 수정 X
		
		// 상품에 관한 request.getParameter
		int shareUsePoint = Integer.parseInt(request.getParameter("shareUsePoint"));
		int remainderUsePotin = Integer.parseInt(request.getParameter("remainderUsePotin"));
		int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
		
		// 상품이 여러개이기에 ArrayListHashMap으로 묶기
		ArrayList<HashMap<String, Object>> orderList = new ArrayList<HashMap<String,Object>>();
		for(int i = 0; i < goodsCodeArr.length; i++) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("fileName", fileNameArr[i]);
			map.put("goodsCode", goodsCodeArr[i]);
			map.put("goodsName", goodsNameArr[i]);
			map.put("goodsPrice", goodsPriceArr[i]);
			map.put("goodsOption", goodsOptionArr[i]);
			map.put("orderQuantity", orderQuantityArr[i]);
			map.put("shareUsePoint", shareUsePoint);
			map.put("remainderUsePotin", remainderUsePotin);
			orderList.add(map);
		}
		
		// 뷰로 넘기기
		request.setAttribute("", orderList);
		request.setAttribute("orderCustomer", orderCustomer);
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute(newAddress, goodsOptionArr);
		
	}
}
