package controller.goods;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.GoodsService;
import service.ReviewService;
import vo.Customer;


@WebServlet("/GoodsOne")
public class GoodsOne extends HttpServlet {
	private GoodsService goodsService;
	private ReviewService reviewService;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션정보 확인(비로그인, 로그인)
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") != null && session.getAttribute("loginMember") instanceof Customer) { // customer 로그인 시,
			Customer loginCustomer = new Customer();
			loginCustomer = (Customer)session.getAttribute("loginMember");
			String customerId = loginCustomer.getCustomerId();
			request.setAttribute("customerId", customerId); // 회원아이디를 세션에 저장
		}
		
		// 파라메터 넘겨받기
		int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
		
		// 서비스 호출
		this.goodsService = new GoodsService();
		HashMap<String, Object> goodsMap = goodsService.getGoodsOne(goodsCode); // 상품코드에 해당하는 상품 보여주기
		
		this.reviewService = new ReviewService();
		ArrayList<HashMap<String, Object>> reviewList = reviewService.getReviewByGoodsCode(goodsCode); // 상품코드에 달린 리뷰 보여주기
		
		// 세션에 저장
		request.setAttribute("goodsMap", goodsMap);
		request.setAttribute("reviewList", reviewList);
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/goods/goodsOne.jsp").forward(request, response);
	}

}
