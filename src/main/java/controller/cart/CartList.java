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
		
		// 세션정보 확인(비로그인, 로그인, 회원, 사원)
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null ) { // 로그인 되어있을 때 DB와 연동하여 장바구니 조회
			Customer loginCustomer = (Customer)session.getAttribute("loginMember");
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		ArrayList<HashMap<String, Object>> list = cartService.getCart(null);
		
		request.getRequestDispatcher("/WEB-INF/view/myPage.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
