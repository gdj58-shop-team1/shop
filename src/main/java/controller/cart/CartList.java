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
 * Servlet implementation class CartList
 */
@WebServlet("/CartList")
public class CartList extends HttpServlet {
	private CartService cartService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") != null && session.getAttribute("loginMember") instanceof Customer) {
			Customer loginCustomer = (Customer) session.getAttribute("loginMember");
			
			cartService = new CartService();
			ArrayList<HashMap<String, Object>> cartList = cartService.getCartList(loginCustomer); // DB에 있는 cart가져오기
			
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
		}
		request.getRequestDispatcher("/WEB-INF/view/cart/cartList.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		String[] goodsCodeArr =  request.getParameterValues("goodsCode");
		String[] orderQuantityArr =  request.getParameterValues("orderQuantity");
		String[] goodsPriceArr =  request.getParameterValues("goodsPrice");
		String[] goodsNameArr =  request.getParameterValues("goodsName");
		String[] fileNameArr =  request.getParameterValues("fileName");
		String[] goodsOptionArr =  request.getParameterValues("goodsOption");
		
		if(session.getAttribute("loginMember") != null && session.getAttribute("loginMember") instanceof Customer) {
			Customer loginCustomer = (Customer) session.getAttribute("loginMember");
			
			// 기존 카트의 모든 DB를 지우기
			cartService = new CartService();
			cartService.removeCartAll(loginCustomer);
			
			for(int i =0; i<goodsCodeArr.length; i++) {
				Cart cart = new Cart();
				cart.setGoodsCode(Integer.parseInt(goodsCodeArr[i]));
				cart.setCustomerId(loginCustomer.getCustomerId());
				cart.setGoodsOption(goodsOptionArr[i]);
				cart.setCartQuantity(Integer.parseInt(orderQuantityArr[i]));
				
				// view에서 가져온 모든 값을 한 행 씩다시 insert
				cartService.addCart(cart);
				
			}
			
			// DB에서 카트 데이터 가져오기
			ArrayList<HashMap<String, Object>> cartList = cartService.getCartList(loginCustomer);
			
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
			ArrayList<HashMap<String, Object>> newCartList = new ArrayList<HashMap<String,Object>>();
			
			for(int i = 0; i<goodsCodeArr.length; i++) {
				int goodsCode =  Integer.parseInt(goodsCodeArr[i]);
				int orderQuantity = Integer.parseInt(orderQuantityArr[i]);
				int goodsPrice = Integer.parseInt(goodsPriceArr[i]);
				String goodsName = goodsNameArr[i];
				String fileName = fileNameArr[i];
				String goodsOption = goodsOptionArr[i];
				
				int goodsOptionPrice = 0;
				if(goodsOption.equals("일반포장")) {
					goodsOptionPrice = 0;
				} else if(goodsOption.equals("고급포장")) {
					goodsOptionPrice = 2500;
				} else if(goodsOption.equals("보자기")) {
					goodsOptionPrice = 5900;
				}
				
				int orderPrice = (goodsPrice + goodsOptionPrice) * orderQuantity;
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("goodsCode", goodsCode);
				map.put("orderQuantity", orderQuantity);
				map.put("goodsPrice", goodsPrice);
				map.put("goodsName", goodsName);
				map.put("fileName", fileName);
				map.put("goodsOption", goodsOption);
				map.put("goodsOptionPrice", goodsOptionPrice);
				map.put("orderPrice", orderPrice);
				System.out.println("goodsOption : " + map.get("goodsOption"));
				newCartList.add(map);
			}
			
			session.setAttribute("cartList", newCartList);
		}
		
		request.getRequestDispatcher("/WEB-INF/view/cart/cartList.jsp").forward(request, response);		
	}

}
