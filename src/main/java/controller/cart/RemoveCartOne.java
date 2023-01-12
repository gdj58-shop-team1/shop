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
 * Servlet implementation class RemoveCartOne
 */
@WebServlet("/RemoveCartOne")
public class RemoveCartOne extends HttpServlet {
	private CartService cartService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int goodsCode =  Integer.parseInt(request.getParameter("goodsCode"));
		request.setAttribute("goodsCode", goodsCode);
		this.doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		
		int goodsCode =  Integer.parseInt(request.getParameter("goodsCode"));
		String goodsOption = request.getParameter("goodsOption");
		
		ArrayList<HashMap<String, Object>> cartList = (ArrayList<HashMap<String, Object>>) session.getAttribute("cartList");
		
		for(int i = 0; i<cartList.size(); i++) {
			if(goodsCode == (int)cartList.get(i).get("goodsCode")) {
				cartList.remove(i);
			}
		}
		
		session.setAttribute("cartList", null);
		session.setAttribute("cartList", cartList);	

		if(session.getAttribute("loginMember") != null && session.getAttribute("loginMember") instanceof Customer) { // 회원 로그인 되어있을 때 DB와 연동하여 장바구니 조회 
			Customer loginCustomer = (Customer)session.getAttribute("loginMember");
			
			Cart cart = new Cart(); 
			cart.setCustomerId(loginCustomer.getCustomerId());
			cart.setGoodsCode(goodsCode);
			cart.setGoodsOption(goodsOption);

			this.cartService = new CartService(); 
			cartService.removeCartOne(cart);	 
			
		 }
		 
		response.sendRedirect(request.getContextPath()+"/CartList");
	}

}
