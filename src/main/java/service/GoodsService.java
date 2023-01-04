package service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import dao.GoodsDao;
import util.DBUtil;

public class GoodsService {
	private GoodsDao goodsDao;
	
	// 상품리스트(home) - 검색값X
	public ArrayList<HashMap<String, Object>> getGoodsList(int currentPage, int rowPerPage){
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsList(GoodsService) db 접속");
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow*rowPerPage;
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
			System.out.println("getGoodsList(GoodsService) db 접속");
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow*rowPerPage;
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
	
	// 총 상품 갯수 - 검색값X
	public int getGoodsCnt() {
		int cnt = 0;
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
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
}
