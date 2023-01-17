package controller.goods;

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
import vo.Goods;

@WebServlet("/ModifyGoods")
public class ModifyGoods extends HttpServlet {
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
		int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
		
		System.out.println("goodsCode: "+goodsCode);
		
		HashMap<String, Object> goods = goodsService.getGoodsOneAdmin(goodsCode);
		
		System.out.println(goods.get("goodsName"));
		System.out.println(goods.get("goodsCategory"));
		// 세션 저장
		request.setAttribute("goods", goods);

		// goodsList --> goodsOne(modify)
		request.getRequestDispatcher("/WEB-INF/view/goods/modifyGoods.jsp").forward(request, response);
		
		
	}

	
	
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Emp loginEmp = (Emp)session.getAttribute("loginMember");
		
		// 파라메터 넘겨받기	
		request.setCharacterEncoding("utf-8");
		
		int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
		String goodsName = request.getParameter("goodsName");
		int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
		String goodsCategory = request.getParameter("goodsCategory");
		String soldout = request.getParameter("soldout");
		
		// 디버깅
		System.out.println(request.getParameter("goodsCode"));
		System.out.println(request.getParameter("soldout"));
		System.out.println(request.getParameter("goodsCategory"));
		
		// 데이터 정리 goods vo
		Goods goods = new Goods();
		goods.setGoodsCode(goodsCode);
		goods.setGoodsName(goodsName);
		goods.setGoodsPrice(goodsPrice);
		goods.setGoodsCategory(goodsCategory);
		goods.setSoldout(soldout);
		goods.setEmpId(loginEmp.getEmpId());
		
		// 수정 서비스 호출
		
		GoodsService goodsService = new GoodsService();
		int result = goodsService.modifyGoods(goods);
		if(result == 0 ) {
			System.out.println("수정 실패");
			response.sendRedirect(request.getContextPath()+"/ModifyGoods");
			return;
		}
		System.out.println("수정 성공");
		response.sendRedirect(request.getContextPath()+"/GoodsList");
		
		
		
	}
	
}

