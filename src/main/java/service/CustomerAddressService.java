 package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dao.CustomerAddressDao;
import util.DBUtil;
import vo.CustomerAddress;

public class CustomerAddressService {
	private CustomerAddressDao customerAddressDao;
	private DBUtil dbUtil;
	
	// 회원 주소 조회(select) : AddOrderDirect
	public ArrayList<CustomerAddress> getAddressByCustomerId(String customerId){
		ArrayList<CustomerAddress> addressList = new ArrayList<CustomerAddress>();
		this.customerAddressDao = new CustomerAddressDao();
		this.dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("getAddressByCustomerId(CustomerAddressService) db 접속");
			addressList = customerAddressDao.selectAddressByCustomerId(conn, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return addressList;
	}
	
	// 회원 주소 조회(select) : orderComplete
	public String selectAddressByOrderCode(int orderCode){
		String address = null;
		this.customerAddressDao = new CustomerAddressDao();
		this.dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("selectAddressByOrderCode(CustomerAddressService) db 접속");
			address = customerAddressDao.selectAddressByOrderCode(conn, orderCode);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return address;
	}
	
	// 회원 주소 추가
	public int addAddress(CustomerAddress paramAddress){
		int row = 0;
		this.customerAddressDao = new CustomerAddressDao();
		this.dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("addAddress(CustomerAddressService) db 접속");
			conn.setAutoCommit(false);
			row = customerAddressDao.insertAddress(conn, paramAddress);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// 새로 추가된 주소의 주소코드 출력
	public int getAddressCode(String customerId){
		int addressCode = 0;
		this.customerAddressDao = new CustomerAddressDao();
		this.dbUtil = new DBUtil();
		Connection conn = null;

		try {
			conn = dbUtil.getConnection();
			System.out.println("selectAddressCode(CustomerAddressService) db 접속");
			addressCode = customerAddressDao.selectAddressCode(conn, customerId);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return addressCode;
	}
	
	// 회원 주소 수정
	public int modifyAddress(CustomerAddress paramAddress){
		int row = 0;
		this.customerAddressDao = new CustomerAddressDao();
		this.dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("modifyAddress(CustomerAddressService) db 접속");
			conn.setAutoCommit(false);
			row = customerAddressDao.updateAddress(conn, paramAddress);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
	
	// 회원 주소 삭제
	public int removeAddress(int addressCode){
		int row = 0;
		this.customerAddressDao = new CustomerAddressDao();
		this.dbUtil = new DBUtil();
		Connection conn = null;
		
		try {
			conn = dbUtil.getConnection();
			System.out.println("removeAddress(CustomerAddressService) db 접속");
			conn.setAutoCommit(false);
			row = customerAddressDao.deleteAddress(conn, addressCode);
			conn.commit();
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return row;
	}
}
