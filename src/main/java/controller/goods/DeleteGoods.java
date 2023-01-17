package controller.goods;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.GoodsService;
import vo.Emp;


@WebServlet("/DeleteGoods")
public class DeleteGoods extends HttpServlet {
	
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
		
		// 파라미터 수집
			if(request.getParameter("goodsCode") == null || ("").equals(request.getParameter("goodsCode"))
				|| request.getParameter("fileName") == null || ("").equals(request.getParameter("fileName"))) {
				response.sendRedirect(request.getContextPath() + "/goodsList");
				return;
			}
			int goodsCode = Integer.parseInt(request.getParameter("goodsCode"));
			String dir = request.getServletContext().getRealPath("/upload");
			String fileName = request.getParameter("fileName");
			
			// 서비스 호출
			goodsService = new GoodsService();
			int result = goodsService.removeGoods(goodsCode);
			
			if(result == 1) {
				File f = new File(dir + "\\" + fileName);
				if(f.exists()) {
					f.delete();
					System.out.println("삭제 성공");
				}			
			} else {
				System.out.println("삭제 실패");
			}
	

		
		// 삭제후 보여지는 view -> goodsList		
		response.sendRedirect(request.getContextPath()+"/GoodsList");
		
	}

}
