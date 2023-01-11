package controller;

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


@WebServlet("/AddGoodsList")
public class AddGoodsList extends HttpServlet {

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

	
		request.getRequestDispatcher("/WEB-INF/view/goods/addGoodsList.jsp").forward(request, response);
	}	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 직원이 아니라면 직원 home 페이지 전환
		HttpSession session = request.getSession();
		if(session.getAttribute("loginEmp") == null) {
			response.sendRedirect(request.getContextPath() + "/Home");
			return;
		}

		
		// new MultipartRequest(원본 request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
		
		request.setCharacterEncoding("utf-8"); // 한글
		String dir = request.getServletContext().getRealPath("upload"); // 이미지를 담을 폴더 (실제 물리적 위치를 반환)
		int maxFileSize = 1024 * 1024 * 100; //최대 파일 크기 (100Mbyte)
		
		DefaultFileRenamePolicy fp = new DefaultFileRenamePolicy(); //파일 이름중복x ex a1, a2...
		MultipartRequest mreq = new MultipartRequest(request, dir, maxFileSize, "utf-8", fp);
		
		
		ArrayList<HashMap<String, Object>> fileList = new ArrayList<>();
		Enumeration<?> files = mreq.getFileNames();
		int fileSeq = 1;
		while(files.hasMoreElements()) {
			HashMap<String, Object> fileMap = new HashMap<String, Object>();
			fileMap.put("filename", mreq.getFilesystemName("filename"+fileSeq));
			fileMap.put("originName", mreq.getOriginalFileName("filename"+fileSeq));
			fileMap.put("contentType", mreq.getContentType("filename"+fileSeq));	
			
			System.out.println("맵에 들어가는지 - 파일 확장자"+fileSeq+": " + mreq.getContentType("filename"+fileSeq));
			
			fileSeq++;
			if(fileMap.get("contentType") == null) {
				break;
			}
			fileList.add(fileMap);
		}

		
		// 이미지파일 검사
		String contentType = mreq.getContentType("goodsImg"); //파일확장자
		String goodsName = mreq.getParameter("goodsName");
		String contentOriginalFileName = mreq.getOriginalFileName("goodsImg"); // 원본 파일 이름
		String fileSystemName = mreq.getFilesystemName("goodsImg"); // 저장된 파일 이름(DefaultFileRenamePolicy fp);
		int goodsPrice = Integer.parseInt(mreq.getParameter("goodsPrice"));
		String soldOut = mreq.getParameter("soldOut");
		Emp loginEmp = (Emp)session.getAttribute("loginEmp");
		String empId = loginEmp.getEmpId();
		int hit = Integer.parseInt(mreq.getParameter("hit"));
		String goodsCategory = mreq.getParameter("goodsCategory");
		

		Goods goods = null;
		GoodsImg goodsImg = null;
		ArrayList<GoodsImg> list = new ArrayList<GoodsImg>();
		for(HashMap<String, Object> m : fileList) {
			if(contentType.equals("image/png") || contentType.equals("image/png")) {
				
				// goods vo
				goods = new Goods();
				goods.setGoodsName(goodsName);
				goods.setGoodsPrice(goodsPrice);
				goods.setGoodsCategory(goodsCategory);
				goods.setSoldout(soldOut);
				goods.setEmpId(empId);
				goods.setHit(hit);
				// goods.setCreatedate(createdate);
				
				
				// goodsImg vo
				goodsImg = new GoodsImg();
				goodsImg.setFileName((String)m.get("filename"));
				goodsImg.setOriginName((String)m.get("originName"));
				goodsImg.setContentType((String)m.get("contentType"));
				list.add(goodsImg);
				
				
			}else {
					System.out.print("*.jpg, *.png파일만 업로드 가능");
					File f = new File(dir + "\\" + m.get("filename"));
					if(f.exists()) {
						f.delete();
				}
			}
		}
			
		

		// service 호출
		GoodsService goodsService = new GoodsService();
		int result = goodsService.getAddGoods(goods, list, dir);
		
		if(result != 1) {
			System.out.println("상품 추가 실패");
		}	
			

		response.sendRedirect(request.getContextPath()+"/AddGoodsList");
		
	}

}
