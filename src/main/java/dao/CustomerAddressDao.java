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
	
	// 회원 주소 조회(select) : orderComplete
	public String selectAddressByOrderCode(Connection conn, int addressCode) throws Exception{
		String address = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT address FROM customer_address WHERE address_code = ?;";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, addressCode);
		rs = stmt.executeQuery();
		if(rs.next()) {
			address = rs.getString("address");
		}
		rs.close();
		stmt.close();
		return address;
	}
	
	// 회원 주소 추가
	public int insertAddress(Connection conn, CustomerAddress paramAddress) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO customer_address (customer_id, address) VALUES (?, ?)";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramAddress.getCustomerId());
		stmt.setString(2, paramAddress.getAddress());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 회원 주소 수정
	public int updateAddress(Connection conn, CustomerAddress paramAddress) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE customer_address SET address = ? WHERE address_code = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramAddress.getAddress());
		stmt.setInt(2, paramAddress.getAddressCode());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 회원 주소 삭제
	public int deleteAddress(Connection conn, int addressCode) throws Exception{
		int row = 0;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM customer_address WHERE address_code = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, addressCode);
		row = stmt.executeUpdate();
		
		return row;
	}
}
