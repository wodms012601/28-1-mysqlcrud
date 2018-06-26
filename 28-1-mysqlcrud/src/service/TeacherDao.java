/*28th Choi Yun-Seok, 2018.06.26*/
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TeacherDao {
	
	public int insertTeacher(Teacher t) {
		// insertTeacher 메서드 선언
		// 매개변수는 Teacher 클래스 타입의 교사의 이름과 나이를 담은 객체의 주소값을 담은 변수 t
		// 리턴값 int 타입
		
		Connection con = null; 
		PreparedStatement pstmt = null;
		
		try{ // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");
			 
			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";
			
			con = DriverManager.getConnection(URL, dbUserId, dbPassword);
		
			System.out.println("데이터 베이스 연결");
		
			pstmt = con.prepareStatement("INSERT INTO teacher(teacher_name, teacher_age) VALUES (?,?)");
			pstmt.setString(1, t.getTeacherName());
			pstmt.setInt(2, t.getTeacherAge());
			
			pstmt.executeUpdate();
		
		}catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		}finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}		
		return 0;
	}
}