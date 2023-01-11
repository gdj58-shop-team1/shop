 package service;

import java.sql.Connection;
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
	
	// 회원 주소 추가
	
	// 회원 주소 수정
	
	// 회원 주소 삭제
}
