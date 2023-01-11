package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

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
			
			
			
			// 굿즈서비스
			
			
			
			
			
			
			
			
					
		}
		
		
		
		
		
		
		
		
	}

}
