package service;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dao.GoodsDao;
import dao.GoodsImgDao;
import util.DBUtil;
import vo.Goods;
import vo.GoodsImg;

public class GoodsService {
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;
	
	// 상품리스트(home) - 검색, 정렬값X
	public ArrayList<HashMap<String, Object>> getGoodsList(int currentPage, int rowPerPage){
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsList(GoodsService) 검색, 정렬값X db 접속");			
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow+rowPerPage;
			goodsList = goodsDao.selectGoodsList(conn, beginRow, endRow);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return goodsList;
	}
	
	// 상품리스트(home) - 검색값O
	public ArrayList<HashMap<String, Object>> getGoodsList(int currentPage, int rowPerPage, String searchWord){
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsList(GoodsService) 검색O db 접속");
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow+rowPerPage;
			goodsList = goodsDao.selectGoodsList(conn, beginRow, endRow, searchWord);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return goodsList;
	}
	
	// 상품리스트(home) - 정렬값O
	public ArrayList<HashMap<String, Object>> getGoodsListSort(int currentPage, int rowPerPage, String sort){
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsList(GoodsService) 정렬O db 접속");
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow+rowPerPage;
			goodsList = goodsDao.selectGoodsListSort(conn, beginRow, endRow, sort);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return goodsList;
	}
	
	// 총 상품 갯수 - 검색값X
	public int getGoodsCnt() {
		int cnt = 0;
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsCnt(GoodsService) db 접속");
			cnt = goodsDao.selectGoodsListCnt(conn);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return cnt;
	}
	
	// 총 상품 갯수 - 검색값O
	public int getGoodsCnt(String searchWord) {
		int cnt = 0;
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsCnt(GoodsService) 검색O db 접속");
			cnt = goodsDao.selectGoodsListCnt(conn, searchWord);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return cnt;
	}
	
	// 상품 상세페이지
	public HashMap<String, Object> getGoodsOne(int goodsCode){
		HashMap<String, Object> goodsMap = null;
		Connection conn = null;
		goodsDao = new GoodsDao();
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsOne(GoodsService) db 접속");
			goodsMap = goodsDao.selectGoodsOne(conn, goodsCode);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return goodsMap;
	}
	
	// 상품 등록하기
	public int getAddGoodsList(Goods goods, GoodsImg goodsImg, String dir) {
		int row = 0;
		goodsDao = new GoodsDao();
		goodsImgDao = new GoodsImgDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsOne(GoodsService) db 접속");
			HashMap<String, Integer> map = goodsDao.insertGoods(conn, goods);
			
			goodsImg.setGoodsCode(map.get("autoKey"));
			
			int insertGoodsRow1 = map.get("row");
			int insertGoodsRow2 = goodsImgDao.insertGoods(conn, goodsImg); 
			
			if(insertGoodsRow1 != 1 || insertGoodsRow2 != 1 ) { // 둘 중 어느하나라도 정상수행이 안되면 예외발생시켜서 롤백시키기
				row = 0;
				throw new Exception();
			} else {
				row = 1;
			}
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
				// 이미 업로드된 파일 삭제
				File f = new File(dir + "\\" + goodsImg.getFileName());
				if (f.exists()) { //파일이 존재한다면
					f.delete(); // 파일삭제
				}
				return row;
			} catch(SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}

		
		return row;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
