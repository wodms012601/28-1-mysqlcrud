package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberAddrDao {
	
	public ArrayList<Member> addrList(String no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			// Class 클래스의 forName()함수를 이용하여 해당 클래스 메모리를 로드한다("동적로딩")
			
			
			String jdbcDriver = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUser = "dev28id";
			String dbPass = "dev28pw";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			pstmt = conn.prepareStatement("select ");
			System.out.println(conn + "<-- Conn의 값");
		} catch(SQLException e) {
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				} 
				catch(SQLException e) {
					e.printStackTrace();
				}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
		}
		return null;
	}
}
