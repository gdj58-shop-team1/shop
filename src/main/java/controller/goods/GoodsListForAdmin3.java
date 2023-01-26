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
import vo.Goods;

/**
 * Servlet implementation class GoodsListForAdmin3
 */
@WebServlet("/GoodsListForAdmin3")
public class GoodsListForAdmin3 extends HttpServlet {
	private GoodsService goodsService;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// 세션정보 확인(비로그인, 로그인, 회원, 사원) + 로그인 레벨 확인
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") == null) {
			response.sendRedirect(request.getContextPath()+"/Home");
			return;
		}
		
		// 세션이 있다면 레벨 확인 -> 레벨 3
		Emp loginEmp = (Emp)session.getAttribute("loginMember");
		int autoCode = loginEmp.getAuthCode();
		if(autoCode < 3) {
			System.out.println("최상위 관리자만 들어올 수 있습니다");
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
	
		// service 호출
		goodsService = new GoodsService();
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<HashMap<String, Object>> sideGoodsList = new ArrayList<HashMap<String, Object>>();//side
		

		goodsList = goodsService.getGoodsListForAdmin3(currentPage, rowPerPage);
		cnt = goodsService.getGoodsCnt();
		//side
		sideGoodsList = goodsService.getSideGoodsList(1, 3); 
	
		// 마지막 페이지구하기
		cnt = goodsService.getGoodsCnt();
		endPage = cnt/rowPerPage;
		if(cnt%rowPerPage != 0) {
			endPage++;
		}
		
		// 세션 저장
		request.setAttribute("goodsList", goodsList);
		request.setAttribute("sideGoodsList", sideGoodsList);
		request.setAttribute("endPage", endPage);
		request.setAttribute("currentPage", currentPage);	

		// view 호출
		request.getRequestDispatcher("/WEB-INF/view/goods/goodsListForAdmin3.jsp").forward(request, response);

	}
		
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
				
		
		// 파라메터 넘겨받기	
		
		int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
		int hit = Integer.parseInt(request.getParameter("hit"));
		
		System.out.println(request.getParameter("goodsCode"));
		
		// 데이터 정리
		Goods goods = new Goods();
		goods.setGoodsCode(goodsCode);
		goods.setHit(hit);
		
		// 서비스 호출
		GoodsService goodsService = new GoodsService();
		int result = goodsService.modifyGoodsForAdmin3(goods);
		if(result == 0) {
			System.out.println("수정실패");
			response.sendRedirect(request.getContextPath()+"/GoodsListForAdmin3");
			return;
		}
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/GoodsListForAdmin3");
	
		
	}

}
