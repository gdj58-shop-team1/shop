package controller.cart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.CartService;
import vo.Cart;
import vo.Customer;

/**
 * Servlet implementation class RemoveCartAll
 */
@WebServlet("/RemoveCartAll")
public class RemoveCartAll extends HttpServlet {
	private CartService cartService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		session.setAttribute("cartList", null);
		
		if(session.getAttribute("loginMember") != null && session.getAttribute("loginMember") instanceof Customer) { // 회원 로그인 되어있을 때 DB와 연동하여 장바구니 조회 
			Customer loginCustomer = (Customer)session.getAttribute("loginMember");
			
			Cart cart = new Cart(); 
			cart.setCustomerId(loginCustomer.getCustomerId());

			this.cartService = new CartService(); 
			cartService.removeCartAll(cart);
			
		 }
		 
		response.sendRedirect(request.getContextPath()+"/CartList");
	}

}
