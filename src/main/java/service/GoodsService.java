package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import dao.GoodsDao;
import util.DBUtil;

public class GoodsService {
	private GoodsDao goodsDao;
	
	// 상품리스트(home) - 검색, 정렬값X
	public ArrayList<HashMap<String, Object>> getGoodsList(int currentPage, int rowPerPage){
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsList(GoodsService) 검색, 정렬값X db 접속");
			System.out.println("currentPage: "+currentPage);
			System.out.println("rowPerPage: "+rowPerPage);
			
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow+rowPerPage;
			System.out.println("beginRow: "+beginRow);
			System.out.println("endRow: "+endRow);
			
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
}