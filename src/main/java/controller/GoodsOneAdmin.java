package controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.GoodsService;
import vo.Emp;

@WebServlet("/GoodsOneAdmin")
public class GoodsOneAdmin extends HttpServlet {
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
		
		
		// 서비스 호출 
		GoodsService goodsService = new GoodsService();
		int goodsCode = Integer.parseInt(request.getParameter("goodsCods"));
		
		System.out.println("goodsCode: "+goodsCode);
		
		HashMap<String, Object> goods = goodsService.getGoodsOneAdmin(goodsCode);
		
		
		// 세션 저장
		request.setAttribute("goods", goods);
		
		
		
		
		
		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/goods/goodsOne.jsp").forward(request, response);
		
	}

}
