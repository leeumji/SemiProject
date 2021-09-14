package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	// DB 사용 전 한번만 실행 (jar가 있는지 확인)
	public static void initConnection() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loading Success");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	// DB연결하기
	public static Connection getConnection() {
		Connection conn = null;
		
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
			System.out.println("Oracle Connection Success!!");
		} catch (SQLException e) {
			System.out.println("DB를 연결하지 못했습니다");
		}
		return conn;
	}
}
