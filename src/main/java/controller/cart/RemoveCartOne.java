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
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") != null && session.getAttribute("loginMember") instanceof Customer) { // 회원 로그인 되어있을 때 DB와 연동하여 장바구니 조회
			Customer loginCustomer = (Customer)session.getAttribute("loginMember");

			int goodsCode =  Integer.parseInt(request.getParameter("goodsCode"));
			
			Cart cart = new Cart();
			cart.setCustomerId(loginCustomer.getCustomerId());
			cart.setGoodsCode(goodsCode);
			
			this.cartService = new CartService();
			cartService.removeCartOne(cart);
			
			
		} else if(session.getAttribute("loginMember") == null) { // 비 로그인일 경우 세션으로 장바구니 조회
			ArrayList<HashMap<String, Object>> cartList = (ArrayList<HashMap<String, Object>>) session.getAttribute("cartList");
			
			int goodsCode =  Integer.parseInt(request.getParameter("goodsCode"));
			
			int CartNum = 0;
			
			for(int i = 0 ; i< cartList.size() ; i++) {
				if((int)cartList.get(i).get(goodsCode) == goodsCode) {
					CartNum = i;
				}
			}
			
			cartList.remove(CartNum);
			session.setAttribute("cartList", cartList);
		}
	}

}
