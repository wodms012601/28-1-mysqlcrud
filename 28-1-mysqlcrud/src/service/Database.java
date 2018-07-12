package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
	
	//드라이버 로딩 및 db연결하는 메서드
	public Connection databaseConnect() {
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
		String dbId = "dev28id";
		String dbPw = "dev28pw";
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection(url, dbId, dbPw); //db연결(ip, 포트번호, db명, dbid, dbpw);
			System.out.println("연결 확인");
			
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return conn; //Connection객체의 주소값을 리턴
	}
}
