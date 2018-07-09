//탁재은, 2018.07.09
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class EmployerDao {
	
	//db의 고용주 테이블에 고용주데이터를 저장
	public void insertEmployer(Employer emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//고용주테이블에 고용주이름과 고용주나이를 저장하는 쿼리문 준비
			pstmt = conn.prepareStatement("insert into employer (employer_name, employer_age) values (?, ?)");
			
			pstmt.setString(1, emp.getEmployerName()); //고용주이름
			pstmt.setInt(2, emp.getEmployerAge()); //고용주나이
			
			pstmt.executeUpdate(); //쿼리문 실행
			System.out.println("고용주테이블저장");
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally{
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
