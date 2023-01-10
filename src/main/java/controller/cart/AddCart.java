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
import vo.Goods;

/**
 * Servlet implementation class AddCart
 */
@WebServlet("/AddCart")
public class AddCart extends HttpServlet {
	private CartService cartService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") != null && session.getAttribute("loginMember") instanceof Customer) { // 회원 로그인 되어있을 때 DB와 연동하여 장바구니 조회
			Customer loginCustomer = (Customer)session.getAttribute("loginMember");

			int goodsCode =  Integer.parseInt(request.getParameter("goodsCode"));
			int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
			
			Cart cart = new Cart();
			cart.setCustomerId(loginCustomer.getCustomerId());
			cart.setGoodsCode(goodsCode);
			cart.setCartQuantity(cartQuantity);
			
			this.cartService = new CartService();
			if(cartService.confirmCart(cart) == 0) { // 카트에 담겨있지않은 물걸
				cartService.addCart(cart);
			} else if (cartService.confirmCart(cart) == 1) { // 카트에 담겨있는 물걸
				cartService.modifyCart(cart);
			}
			
		} else if(session.getAttribute("loginMember") == null){ // 비 로그인일 경우 세션으로 장바구니 조회
			if(session.getAttribute("cartList") == null) { // 세션에 저장한 cartList가없을 경우 생성
				ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
				
				session.setAttribute("cartList", list);
			}
			
			
			ArrayList<HashMap<String, Object>> cartList = (ArrayList<HashMap<String, Object>>) session.getAttribute("cartList");
			int goodsCode =  Integer.parseInt(request.getParameter("goodsCode"));
			int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
			String goodsName = request.getParameter("goodsName");
			String fileName = request.getParameter("fileName");
			
			int countGoodsCode = 0;
			int CartNum = 0;
			
			for(int i = 0 ; i< cartList.size() ; i++) {
				if((int)cartList.get(i).get(goodsCode) == goodsCode) {
					countGoodsCode++;
					CartNum = i;
				}
			}
			
			if(countGoodsCode == 0) { // 카트(세션)에 담겨있지않은 물건 개수 수정
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("goodsCode", goodsCode);
				map.put("cartQuantity", cartQuantity);
				map.put("goodsName", goodsName);
				map.put("fileName", fileName);
				cartList.add(map);
			} else if (countGoodsCode > 0) { // 카트(세션)에 담겨있는 물건 개수 수정
				cartList.get(CartNum).replace("cartQuantity", cartQuantity);
			}
			
			session.setAttribute("cartList", cartList);
		}
	}

}
