package service;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dao.GoodsDao;
import dao.GoodsImgDao;
import util.DBUtil;
import vo.Emp;
import vo.Goods;
import vo.GoodsImg;

public class GoodsService {
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;
	
	// 상품리스트(home) - 검색, 정렬값X
	public ArrayList<HashMap<String, Object>> getGoodsList(int currentPage, int rowPerPage, String whrere, String sort){
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsList(GoodsService) 검색, 정렬값X db 접속");			
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow+rowPerPage;
			goodsList = goodsDao.selectGoodsListTest(conn, beginRow, endRow, whrere, sort);
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
	
	// 총 상품 갯수
	public int getGoodsCnt(String where) {
		int cnt = 0;
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getGoodsCnt(GoodsService) 검색O db 접속");
			cnt = goodsDao.selectGoodsListCnt(conn, where);
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
	
	// admin) 상품 등록하기
	public int getAddGoods(Goods goods, GoodsImg goodsImg, String dir) {
		
		int insertGoodsRow = 0;
		int insertGoodsImgRow = 0;
		
		goodsDao = new GoodsDao();
		goodsImgDao = new GoodsImgDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			HashMap<String, Integer> m = goodsDao.insertGoods(conn, goods);
			
			if (m.get("result") == 1 ) {
				System.out.println("굿즈정보등록 성공");
			} else { 
				System.out.println("굿즈정보등록 실패");
				throw new Exception();
			}
			
			int autoKey = m.get("autoKey");
			insertGoodsImgRow = goodsImgDao.insertGoodsImg(conn, goodsImg, autoKey);
			
			if (insertGoodsImgRow  == 1) {
				System.out.println("이미지 등록성공");
			} else {
				System.out.println("이미지 등록실패");
				throw new Exception();
			
			}
		 
			conn.commit();
			
		} catch( Exception e ) {
			try {
				conn.rollback();
				
				// 이미 업로드된 파일 삭제
				File f = new File(dir + "\\" + goodsImg.getFileName());
				if (f.exists()) { //파일이 존재한다면 
					f.delete();	//파일삭제
					System.out.println("delete");
				}
				return insertGoodsImgRow;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if(conn != null) {
				try { 
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return insertGoodsRow;
		
	}
	
	// admin) 상품 리스트
	public ArrayList<HashMap <String, Object>> getGoodsListAdmin(Emp emp, int currentPage, int rowPerPage) {
		ArrayList<HashMap<String, Object>> goodsList = null;
		goodsDao = new GoodsDao();
		goodsImgDao = new GoodsImgDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow+rowPerPage;
			goodsList = goodsDao.selectGoodsListAdmin(conn, emp, beginRow, endRow);
			
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
	
	// admin) 상품one 상세페이지
		public HashMap<String, Object> getGoodsOneAdmin(int goodsCode){
			HashMap<String, Object> goodsMap = null;
			Connection conn = null;
			goodsDao = new GoodsDao();
			DBUtil dbUtil = new DBUtil();
			
			try {
				conn = dbUtil.getConnection();
				System.out.println("getGoodsOneAdmin(GoodsService) db 접속");
				goodsMap = goodsDao.selectGoodsOneAdmin(conn, goodsCode);
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

	
	// admin) 상품수정
	public int modifyGoods(Goods goods) {
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
	
		int row = 0;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			row = goodsDao.updateGoods(conn, goods);
		
			if (row ==1 ) {
				System.out.println("상품수정 성공");
			} else {
				System.out.println("상품수정 실패");
				throw new Exception();
			}
			conn.commit();
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				if(conn != null) {conn.close();}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return row;
		
	}
	
	
	
	// admin) 상품삭제
	
	public int removeGoods(int goodsCode) {
		goodsDao = new GoodsDao();
		goodsImgDao = new GoodsImgDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		int result = 0;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			goodsImgDao = new GoodsImgDao();
			result = goodsImgDao.deleteGoodsImg(conn, goodsCode);
			
			// 상품 삭제 실패 시
			if(result < 1) {
				throw new Exception();
			}
			
			goodsDao = new GoodsDao();
			result = goodsDao.deleteGoods(conn, goodsCode);
			
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if(conn != null) {conn.close();}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	// owner 관리자 레벨 3) 상품 리스트
	public ArrayList<HashMap <String, Object>> getGoodsListForAdmin3(int currentPage, int rowPerPage) {
		ArrayList<HashMap<String, Object>> goodsList = null;
		goodsDao = new GoodsDao();
		goodsImgDao = new GoodsImgDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow+rowPerPage;
			goodsList = goodsDao.selectGoodsListForAdmin3(conn, beginRow, endRow);
			
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
	
	// owner 관리자 레벨 3) hit 수정
	public int modifyGoodsForAdmin3(Goods goods) {
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
	
		int row = 0;
		
		try {
			conn = dbUtil.getConnection();
			conn.setAutoCommit(false);
			
			row = goodsDao.updateGoodsForAdmin3(conn, goods);
		
			if (row ==1 ) {
				System.out.println("hit 성공");
			} else {
				System.out.println("hit 실패");
				throw new Exception();
			}
			conn.commit();
		} catch(Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				if(conn != null) {conn.close();}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return row;
		
	}
	
	// 상품리스트(home) - 검색, 정렬값X
	public ArrayList<HashMap<String, Object>> getSideGoodsList(int currentPage, int rowPerPage){
		ArrayList<HashMap<String, Object>> SideGoodsList = new ArrayList<HashMap<String, Object>>();
		goodsDao = new GoodsDao();
		Connection conn = null;
		DBUtil dbUtil = new DBUtil();
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getSideGoodsList(GoodsService) db 접속");			
			int beginRow = (currentPage-1)*rowPerPage;
			int endRow = beginRow+rowPerPage;
			SideGoodsList = goodsDao.selectSideGoodsist(conn, beginRow, endRow);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return SideGoodsList;
	}
	
}
