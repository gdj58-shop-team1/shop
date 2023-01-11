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
import vo.Customer;

/**
 * Servlet implementation class CartList
 */
@WebServlet("/CartList")
public class CartList extends HttpServlet {
	private CartService cartService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
				
		request.getRequestDispatcher("/WEB-INF/view/cart/cartList.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		ArrayList<HashMap<String, Object>> cartList = (ArrayList<HashMap<String, Object>>) session.getAttribute("cartList");
		ArrayList<HashMap<String, Object>> newCartList = new ArrayList<HashMap<String,Object>>();
		for(int i = 0; i<cartList.size(); i++) {
			int goodsCode =  Integer.parseInt(request.getParameter("goodsCode"+i));
			int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"+i));
			int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"+i));
			String goodsName = request.getParameter("goodsName"+i);
			String fileName = request.getParameter("fileName"+i);
			String goodsOption = request.getParameter("goodsOption"+i);
			
			int goodsOptionPrice = 0;
			if(goodsOption.equals("일반포장")) {
				goodsOptionPrice = 0;
			} else if(goodsOption.equals("고급포장")) {
				goodsOptionPrice = 2500;
			} else if(goodsOption.equals("보자기")) {
				goodsOptionPrice = 5900;
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("goodsCode", goodsCode);
			map.put("cartQuantity", cartQuantity);
			map.put("goodsPrice", goodsPrice);
			map.put("goodsName", goodsName);
			map.put("fileName", fileName);
			map.put("goodsOption", goodsOption);
			map.put("goodsOptionPrice", goodsOptionPrice);
			newCartList.add(map);
		}
		
		session.setAttribute("CartList", newCartList);
		request.getRequestDispatcher("/WEB-INF/view/cart/cartList.jsp").forward(request, response);
		
	}

}
