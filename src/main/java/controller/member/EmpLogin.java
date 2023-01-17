package controller.member;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CartService;
import service.CustomerService;
import service.EmpService;
import vo.Cart;
import vo.Customer;
import vo.Emp;

/**
 * Servlet implementation class EmpLogin
 */
@WebServlet("/EmpLogin")
public class EmpLogin extends HttpServlet {
	private CustomerService customerService;
	private EmpService empService;
	private CartService cartService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 로그인 전에만 접근가능
		HttpSession session = request.getSession();
		
		// 로그인 여부확인, 로그인 되어있을 경우 회원페이지로 이동	
		if(session.getAttribute("loginMember") != null) {

			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
				
		request.getRequestDispatcher("/WEB-INF/view/empLogin.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Customer loginCustomer = null;
		Emp loginEmp = null;
		
		HttpSession session = request.getSession();
		
		if(request.getParameter("customerId") != null && request.getParameter("customerPw") != null) { // customer 로그인
			Customer customer = new Customer();
			customer.setCustomerId(request.getParameter("customerId"));
			customer.setCustomerPw(request.getParameter("customerPw"));
			
			this.customerService = new CustomerService();
			loginCustomer = customerService.loginCustomer(customer);
			
			// 로그인 전 세션에 담아 두었던 장바구니 DB랑 합치기
			this.cartService = new CartService();
			ArrayList<HashMap<String, Object>> cartList = cartService.getCartList(loginCustomer); // DB에 있는 cart가져오기
			
			if(session.getAttribute("cartList") != null) {
				ArrayList<HashMap<String, Object>> sessionCartList = (ArrayList<HashMap<String, Object>>)session.getAttribute("cartList");
				for(int i = 0; i<sessionCartList.size(); i++) {
					Cart cart = new Cart();
					cart.setGoodsCode((int)sessionCartList.get(i).get("goodsCode"));
					cart.setCustomerId(loginCustomer.getCustomerId());
					cart.setGoodsOption((String)sessionCartList.get(i).get("goodsOption"));
					cart.setCartQuantity((int)sessionCartList.get(i).get("orderQuantity"));
					
					boolean flag = cartService.confirmCart(cart);
					if(flag == false) {
						cartService.addCart(cart);
					} else {
						cartService.modifyCart(cart);
					}
				}
				cartList = cartService.getCartList(loginCustomer);
				
				for(int i = 0; i<cartList.size(); i++) {
					int goodsOptionPrice = 0;
					int goodsPrice = (int) cartList.get(i).get("goodsPrice");
					int orderQuantity = (int) cartList.get(i).get("orderQuantity");
					
					if(cartList.get(i).get("goodsOption").equals("일반포장")) {
						goodsOptionPrice = 0;
					} else if(cartList.get(i).get("goodsOption").equals("고급포장")) {
						goodsOptionPrice = 2500;
					} else if(cartList.get(i).get("goodsOption").equals("보자기")) {
						goodsOptionPrice = 5900;
					}
					
					cartList.get(i).put("goodsOptionPrice", goodsOptionPrice);
					cartList.get(i).put("orderPrice", (goodsOptionPrice + goodsPrice) * orderQuantity);
				}
				
				session.setAttribute("cartList", cartList);
			} else {
				session.setAttribute("cartList", cartList);
			}
			session.setAttribute("loginMember", loginCustomer);
		} else { // emp 로그인
			Emp emp = new Emp();
			System.out.println(request.getParameter("empId"));
			System.out.println(request.getParameter("empPw"));
			emp.setEmpId(request.getParameter("empId"));
			emp.setEmpPw(request.getParameter("empPw"));
			
			this.empService = new EmpService();
			loginEmp = empService.loginEmp(emp);
			
			session.setAttribute("loginMember", loginEmp);
		}

		String message = null;
		
		if(loginCustomer == null && loginEmp == null) {
			message = "로그인 실패";
			message = URLEncoder.encode(message, "UTF-8");
			response.sendRedirect(request.getContextPath()+"/EmpLogin?message="+message);
			return;
		}
		
		message = "로그인 성공!";
		message = URLEncoder.encode(message, "UTF-8");
		response.sendRedirect(request.getContextPath()+"/Home?message="+message);
	}

}