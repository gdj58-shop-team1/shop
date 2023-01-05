package controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.GoodsService;


@WebServlet("/GoodsOne")
public class GoodsOne extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션 유효성 확인(로그인 비로그인 여부)
		
		// 파라메터 넘겨받기
		int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
		
		// 서비스 호출
		GoodsService goodsService = new GoodsService();
		HashMap<String, Object> goodsMap = goodsService.getGoodsOne(goodsCode);
		
		// 세션에 저장
		request.setAttribute("goodsMap", goodsMap);
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/goods/goodsOne.jsp").forward(request, response);
	}

}
