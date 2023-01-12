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
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("cartList") == null) { // 세션에 저장한 cartList가없을 경우 생성
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			
			session.setAttribute("cartList", list);
		}
			
		ArrayList<HashMap<String, Object>> cartList = (ArrayList<HashMap<String, Object>>) session.getAttribute("cartList");
		int goodsCode =  Integer.parseInt(request.getParameter("goodsCode"));
		int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
		int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
		String goodsName = request.getParameter("goodsName");
		String fileName = request.getParameter("fileName");
		String goodsOption = request.getParameter("goodsOption");
		int modifyOrderQuantity = 0;
		
		int goodsOptionPrice = 0;
		if(goodsOption.equals("일반포장")) {
			goodsOptionPrice = 0;
		} else if(goodsOption.equals("고급포장")) {
			goodsOptionPrice = 2500;
		} else if(goodsOption.equals("보자기")) {
			goodsOptionPrice = 5900;
		}
		int orderPrice = (goodsPrice + goodsOptionPrice) * orderQuantity;
		
		int countGoodsCode = 0;
		int CartNum = 0;
			
		for(int i = 0 ; i< cartList.size() ; i++) {
			if((int)cartList.get(i).get("goodsCode") == goodsCode && cartList.get(i).get("goodsOption").equals(goodsOption)) {
				countGoodsCode++;
				CartNum = i;
			}
		}
		
		session.setAttribute("cartList", cartList);

		if(session.getAttribute("loginMember") != null && session.getAttribute("loginMember") instanceof Customer) { // 회원 로그인 되어있을 때 DB와 연동하여 장바구니 조회
			Customer loginCustomer = (Customer)session.getAttribute("loginMember");

			Cart cart = new Cart();
			cart.setCustomerId(loginCustomer.getCustomerId());
			cart.setGoodsCode(goodsCode);
			cart.setCartQuantity(orderQuantity);
			cart.setGoodsOption(goodsOption);
			
			this.cartService = new CartService();
			boolean flag = cartService.confirmCart(cart);
			if(flag == false) { // 카트에 담겨있지않은 물걸
				cartService.addCart(cart);
			} else if (flag == true) { // 카트에 담겨있는 물걸
				cartService.modifyCart(cart);
			}		
		} else {
			if(countGoodsCode == 0) { // 카트(세션)에 담겨있지않은 물건 개수 수정
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("goodsCode", goodsCode);
				map.put("orderQuantity", orderQuantity);
				map.put("goodsPrice", goodsPrice);
				map.put("goodsName", goodsName);
				map.put("fileName", fileName);
				map.put("goodsOption", goodsOption);
				map.put("goodsOptionPrice", goodsOptionPrice);
				map.put("orderPrice", orderPrice);
				cartList.add(map);
			} else if (countGoodsCode > 0) { // 카트(세션)에 담겨있는 물건 개수 수정
				modifyOrderQuantity = (int)cartList.get(CartNum).get("orderQuantity") + orderQuantity;
				cartList.get(CartNum).replace("orderQuantity", modifyOrderQuantity);
				cartList.get(CartNum).replace("orderPrice", (goodsPrice + goodsOptionPrice) * modifyOrderQuantity);
			}
			session.setAttribute("cartList", cartList);
		}
		
		response.sendRedirect(request.getContextPath()+"/GoodsOne?goodsCode="+goodsCode);
	}
}
