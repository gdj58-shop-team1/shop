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
import vo.Emp;



@WebServlet("/GoodsList")
public class GoodsList extends HttpServlet {
	private GoodsService goodsService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션정보 확인(비로그인, 로그인, 회원, 사원) + 로그인 레벨 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		// 세션이 있다면 레벨 확인
		Emp loginEmp = (Emp)session.getAttribute("loginMember");
		int autoCode = loginEmp.getAuthCode();
		if(autoCode < 1) {
			System.out.println("관리자 권한 없음");
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		// 페이지
		int rowPerPage = 5; // 한 페이지 당 보여질 상품 목록 수
		int cnt = 0; // 총 상품 갯수
		int endPage = 0; // 마지막 페이지
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		// side
		

		
		// service 호출
		goodsService = new GoodsService();
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<HashMap<String, Object>> sideGoodsList = new ArrayList<HashMap<String, Object>>();//side
		
		
		goodsList = goodsService.getGoodsListAdmin(loginEmp, currentPage, rowPerPage);
		//cnt = goodsService.getGoodsCnt();
		
		sideGoodsList = goodsService.getSideGoodsList(1, 3); //side
		
		
		// 마지막 페이지구하기
		endPage = cnt/rowPerPage;
		if(cnt%rowPerPage != 0) {
			endPage++;
		}
		request.setAttribute("goodsList", goodsList);
		request.setAttribute("sideGoodsList", sideGoodsList);
		request.setAttribute("endPage", endPage);
		request.setAttribute("currentPage", currentPage);
		
		
		// view 호출
		request.getRequestDispatcher("/WEB-INF/view/goods/goodsList.jsp").forward(request, response);
		
		
		

	}
		
		
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 권한 1부터 가능
		HttpSession session = request.getSession();
		
		// 파라미터 수집
		request.setCharacterEncoding("utf-8"); // 한글
		
		
		
		
		// service 호출
		
		
		
		
	}

}
