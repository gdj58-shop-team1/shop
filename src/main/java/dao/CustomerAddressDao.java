package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import vo.CustomerAddress;

public class CustomerAddressDao {
	
	// 회원 주소 조회(select) : AddOrderDirect
	public ArrayList<CustomerAddress> selectAddressByCustomerId(Connection conn, String customerId) throws Exception{
		ArrayList<CustomerAddress> addressList = new ArrayList<CustomerAddress>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ "	address_code addressCode"
				+ "	, address"
				+ "	, createdate"
				+ " FROM customer_address"
				+ " WHERE customer_id = ?;";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		rs = stmt.executeQuery();
		while(rs.next()) {
			CustomerAddress address = new CustomerAddress();
			address.setAddressCode(rs.getInt("addressCode"));
			address.setAddress(rs.getString("address"));
			address.setCreatedate(rs.getString("createdate"));
			addressList.add(address);
		}
		rs.close();
		stmt.close();
		return addressList;
	}
	
	
	
	// 회원 주소 추가
	
	// 회원 주소 수정
	
	// 회원 주소 삭제
}
