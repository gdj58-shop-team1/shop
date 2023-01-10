package controller.review;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.OrderService;
import service.ReviewService;
import vo.Review;


@WebServlet("/AddReview")
public class AddReview extends HttpServlet {
	private ReviewService reviewService;
	private OrderService orderService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}

		// 파라메터 받기
		int orderCode = Integer.parseInt(request.getParameter("orderCode"));
		System.out.println("orderCode: "+orderCode);
		
		// 서비스 호출(리뷰 작성시 필요한 주문 정보 불러오게끔)
		this.orderService = new OrderService();
		HashMap<String, Object> order = orderService.getOrderByOrderCode(orderCode);
		
		// 세션에 저장
		request.setAttribute("order", order);
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/review/addReview.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		// 파라메터 받기
		request.setCharacterEncoding("utf-8");
		int orderCode = Integer.parseInt(request.getParameter("orderCode"));
		String reviewMemo = request.getParameter("reviewMemo");
		
		// 데이터 묶기
		Review paramReview = new Review();
		paramReview.setOrderCode(orderCode);
		paramReview.setReviewMemo(reviewMemo);
		
		// 서비스 호출
		this.reviewService = new ReviewService();
		int row = reviewService.addReview(paramReview);
		if(row == 0) {
			System.out.println("리뷰 추가 실패");
			response.sendRedirect(request.getContextPath()+"/AddReview");
			return;
		}
		System.out.println("리뷰 추가 성공");
		response.sendRedirect(request.getContextPath()+"/OrderList");
	}

}