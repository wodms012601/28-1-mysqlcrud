package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberAddrDao {
	
	public void insertaddrList(MemberAddr addr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			String jdbcDriver = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUser = "dev28id";
			String dbPass = "dev28pw";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			pstmt = conn.prepareStatement("insert into member_addr(member_no, member_addr_content) values(?,?)");
			pstmt.setInt(1, addr.getMember_no());
			pstmt.setString(2, addr.getMember_addr_content());
			
			pstmt.executeUpdate();
			
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
		
	}
	
	public ArrayList<MemberAddr> addrList(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberAddr> list = new ArrayList<>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			// Class 클래스의 forName()함수를 이용하여 해당 클래스 메모리를 로드한다("동적로딩")
			
			
			String jdbcDriver = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUser = "dev28id";
			String dbPass = "dev28pw";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			pstmt = conn.prepareStatement("select member_addr_no, member_no, member_addr_content from member_addr where member_no=?");
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			MemberAddr m1 = null;
			
			while (rs.next()) {
				m1 = new MemberAddr();
				m1.setMember_addr_no(Integer.parseInt(rs.getString("member_addr_no")));
				m1.setMember_no(Integer.parseInt(rs.getString("member_no")));
				m1.setMember_addr_content(rs.getString("member_addr_content"));
				
				list.add(m1);
			}
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
		return list;
	}
}
