package controller.review;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.ReviewService;
import vo.Customer;
import vo.Emp;


@WebServlet("/ReviewList")
public class ReviewList extends HttpServlet {
	private ReviewService reviewService;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		this.reviewService = new ReviewService();
		Customer loginCustomer = new Customer();
		Emp loginEmp = new Emp();
		
		// 세션 유효성 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) { // 로그인 X -> 로그인 페이지로 이동
			response.sendRedirect(request.getContextPath()+"/Login");
			return;
		}
		
		// 세션에 담긴 정보 확인(회원, 관리자에 따라 리스트 분기)
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<HashMap<String, Object>>();
		
		if(session.getAttribute("loginMember") instanceof Customer) { // customer 로그인 시,
			System.out.println("회원로그인");
			loginCustomer = (Customer)session.getAttribute("loginMember");
			String customerId = loginCustomer.getCustomerId();
			
			reviewList = reviewService.getReviewByCustomerId(customerId); // 회원아이디로 조회 메서드
			
		} else if(session.getAttribute("loginMember") instanceof Emp) { // emp 로그인 시,
			System.out.println("사원로그인");
			loginEmp = (Emp)session.getAttribute("loginMember");
			String empId = loginEmp.getEmpId();
			int autoCode = loginEmp.getAuthCode();
			
			if(autoCode == 3) { // 관리자 레벨이 3이면 모든 리뷰 조회
				reviewList = reviewService.getReviewAll(); // 모든리뷰 조회 메서드
				// System.out.println("모든리뷰 조회");
			} else {
				reviewList = reviewService.getReviewByEmpId(empId); // 그렇지 않으면(레벨이 1,2이면) 관리자아이디로 조회 메서드
				// System.out.println("리뷰선택 조회");
			}
		}
		
		// 세션에 리스트 저장
		request.setAttribute("reviewList", reviewList);
		request.getRequestDispatcher("/WEB-INF/view/review/reviewList.jsp").forward(request, response);
	}

}
