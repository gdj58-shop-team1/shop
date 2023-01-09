package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
	public Connection getConnection() throws Exception {
		
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/shop", "root", "java1234");
		return conn;
		
	}
}
