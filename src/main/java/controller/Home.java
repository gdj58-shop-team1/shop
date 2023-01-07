package controller;

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
import vo.Customer;

@WebServlet("/Home")
public class Home extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/*
			세션분기(비로그인, 로그인) :비로그인 -> loginController, 로그인 -> home.jsp 호출
			페이지 정보 받기(현재 페이지)
			서비스 호출(goodsList)
			goodsList 세션에 저장
			home.jsp 호출
		*/
		
		// 세션정보 확인(비로그인, 로그인, 회원, 사원)
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginMember") != null) {
			request.setAttribute("loginMember", session.getAttribute("loginMember"));
		}
		
		
		// 페이지 정보 받기(검색값, 정렬값, 현재 페이지 값)
		int rowPerPage = 20; // 한 페이지 당 보여질 상품 목록 수
		int cnt = 0; // 총 상품 갯수
		int endPage = 0; // 마지막 페이지
		
		String searchWord = request.getParameter("searchWord"); // 검색값
		String sort = request.getParameter("sort"); // 정렬값
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		// System.out.println("currentPage: "+currentPage);
		// System.out.println("searchWord: "+searchWord);
		// System.out.println("sort: "+sort);
		
		
		// 서비스 호출(goodsList + 페이징(endPage 포함)) - 분기: 검색값 유무, 정렬
		GoodsService goodsService = new GoodsService();
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		
		// 검색값 따라 분기
		if(searchWord != null) { // 검색값이 있으면
			goodsList = goodsService.getGoodsList(currentPage, rowPerPage, searchWord);
			cnt = goodsService.getGoodsCnt(searchWord);
		} else if(sort != null) { // 정렬값이 있으면
			goodsList = goodsService.getGoodsListSort(currentPage, rowPerPage, sort);
			cnt = goodsService.getGoodsCnt();
		} else { // 아무 값 없으면
			goodsList = goodsService.getGoodsList(currentPage, rowPerPage);
			cnt = goodsService.getGoodsCnt();
		}
		
		// 마지막 페이지 구하기
		endPage = cnt/rowPerPage;
		if(cnt%rowPerPage != 0) {
			endPage++;
		}
		// System.out.println("cnt: "+cnt);
		// System.out.println("endPage: "+endPage);
		
		// 세션에 정보 넘기기
		request.setAttribute("goodsList", goodsList);
		request.setAttribute("endPage", endPage);
		request.setAttribute("searchWord", searchWord);
		request.setAttribute("sort", sort);
		request.setAttribute("currentPage", currentPage);
		
		// home.jsp 호출
		request.getRequestDispatcher("/WEB-INF/view/home.jsp").forward(request, response);
		
	}
}
