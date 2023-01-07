package controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.ReviewService;
import vo.Review;


@WebServlet("/ReviewModify")
public class ReviewModify extends HttpServlet {
	private ReviewService reviewService;
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
		
		// 서비스 호출
		this.reviewService = new ReviewService();
		HashMap<String, Object> map = reviewService.getReviewByOrderCode(orderCode); 
		
		// 세션에 저장
		request.setAttribute("review", map);
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/review/modifyReview.jsp").forward(request, response);
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
		int row = reviewService.modifyReview(paramReview);
		if(row == 0) {
			System.out.println("리뷰 수정 실패");
			response.sendRedirect(request.getContextPath()+"/ReviewModify");
			return;
		}
		System.out.println("리뷰 수정 성공");
		response.sendRedirect(request.getContextPath()+"/ReviewList");
	}

}
