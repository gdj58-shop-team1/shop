package controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import service.GoodsService;
import vo.Goods;
import vo.GoodsImg;


@WebServlet("/AddGoodsList")
public class AddGoodsList extends HttpServlet {

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/view/goods/addGoodsList.jsp").forward(request, response);
	}	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// new MultipartRequest(원본 request, 업로드폴더, 최대파일사이즈byte, 인코딩, 중복이름정책)
		
		String dir = request.getServletContext().getRealPath("upload"); // 이미지를 담을 폴더 (실제 물리적 위치를 반환)
		int maxFileSize = 1024 * 1024 * 100; //최대 파일 크기 (100Mbyte)
		
		DefaultFileRenamePolicy fp = new DefaultFileRenamePolicy(); //파일 이름중복x ex a1, a2...
		MultipartRequest mreq = new MultipartRequest(request, dir, maxFileSize, "utf-8", fp);
		
		
		// 이미지파일 검사
		String contentType = mreq.getContentType("goodsImg"); //파일형식
		if(contentType.equals("image/png") || contentType.equals("image/png")) {
			String goodsName = mreq.getParameter("goodsName");
			String contentOriginalFileName = mreq.getOriginalFileName("goodsImg"); // 원본 파일 이름
			String fileSystemName = mreq.getFilesystemName("goodsImg"); // 저장된 파일 이름(DefaultFileRenamePolicy fp);
		
			Goods goods = new Goods();
			goods.setGoodsName(goodsName);
			
			GoodsImg goodsImg = new GoodsImg();
			goodsImg.setFileName(fileSystemName); // 중복된 파일이름 -> 변환된 파일이름으로 등록
			
			GoodsService goodsService = new GoodsService();
			if(goodsService.getAddGoodsList(goods, goodsImg, dir) == 1 ) {
				System.out.println("이미지 업로드 성공");
			} else {
				System.out.println("이미지 업로드 실패");
			}
		} else {
			System.out.println("*.jpg, *.png 파일만 업로드 가능");
			File file = new File(dir+"\\"+mreq.getFilesystemName("goodsImg"));
			
			if(file.exists()) {
				file.delete(); // 이미지가 아닌 파일이 업로드 되었기 때문에 삭제
			}

		}
		response.sendRedirect(request.getContextPath()+"/AddGoodsList");
		
	}

}
