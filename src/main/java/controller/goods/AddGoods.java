package controller.goods;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import service.GoodsService;
import vo.Emp;
import vo.Goods;
import vo.GoodsImg;


@WebServlet("/AddGoods")
public class AddGoods extends HttpServlet {

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

		// 뷰 호출
		request.getRequestDispatcher("/WEB-INF/view/goods/addGoods.jsp").forward(request, response);
	}	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 권한 1부터 가능
		HttpSession session = request.getSession();
	
		
		// 파라미터 수집
		request.setCharacterEncoding("utf-8"); // 한글
		String dir = request.getServletContext().getRealPath("/upload"); // 이미지를 담을 폴더 (실제 물리적 위치를 반환)
		int maxFileSize = 1024 * 1024 * 100; //최대 파일 크기 (100Mbyte)
		System.out.println("============ uploadFilePath = " + dir);
		DefaultFileRenamePolicy fp = new DefaultFileRenamePolicy(); //파일 이름중복x ex a1, a2...
		// new MultipartRequest(원본 request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
		MultipartRequest mreq = new MultipartRequest(request, dir, maxFileSize, "utf-8", fp);
		
		String contentType = mreq.getContentType("goodsImg"); // 파일 형식
		String contentOriginalFileName = mreq.getOriginalFileName("goodsImg"); // 원본파일 이름
		String fileSystemName = mreq.getFilesystemName("goodsImg"); // 저장된 파일 이름(DefaultFileRenamePolicy fp);

		
		// 이미지파일 검사
		String goodsName = mreq.getParameter("goodsName");
		int goodsPrice = Integer.parseInt(mreq.getParameter("goodsPrice"));
		String soldout = mreq.getParameter("soldout");
		String goodsCategory = mreq.getParameter("goodsCategory");
		Emp loginEmp = (Emp)session.getAttribute("loginMember");
		String empId = loginEmp.getEmpId();
		//int hit = Integer.parseInt(mreq.getParameter("hit"));
		
		/* 디버깅
		System.out.println(contentType);
		System.out.println(contentOriginalFileName);
		System.out.println(fileSystemName);
		
		System.out.println(goodsName);
		System.out.println(goodsPrice);
		System.out.println(soldout);
		System.out.println(hit);
		System.out.println(goodsCategory);
		*/
		

		Goods goods = null;
		GoodsImg goodsImg = null;
		ArrayList<GoodsImg> list = new ArrayList<GoodsImg>();
		
			if(contentType.equals("image/png") || contentType.equals("image/jpeg")) {
				
				// goods 
				goods = new Goods();
				goods.setGoodsName(goodsName);
				goods.setGoodsPrice(goodsPrice);
				goods.setGoodsCategory(goodsCategory);
				goods.setSoldout(soldout);
				goods.setEmpId(empId);
				// goods.setHit(hit);
				// goods.setCreatedate(createdate);
				
				
				// goodsImg 
				goodsImg = new GoodsImg();
				goodsImg.setFileName(fileSystemName);
				goodsImg.setOriginName(contentOriginalFileName);
				goodsImg.setContentType(contentType);
				list.add(goodsImg);
				
				
			}else {
					System.out.print("*.jpg, *.png파일만 업로드 가능");
					File f = new File(dir + "\\" + fileSystemName);
					if(f.exists()) {
						f.delete();
				}
			}
		
		// service 호출
		GoodsService goodsService = new GoodsService();
		int result = goodsService.getAddGoods(goods, goodsImg, dir);
		
		if(result != 1) {
			System.out.println("상품 추가 성공");
		}	else {
			System.out.println("상품 추가 실패");
		}
			
		response.sendRedirect(request.getContextPath()+"/GoodsList");
		
			}

	}
	
	
