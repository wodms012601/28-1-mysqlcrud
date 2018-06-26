//탁재은, 2018.06.26
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class StudentDao {
	
	/*db연결 및 학생 테이블에 데이터 상입
	매개변수는 stu객체참조변수로서 stu를 통해 학생데이터를 가져온다.
	insert만 하기때문에 리턴은 사용하지않는다.
	student_no는 기본값으로 auto_increment를 주었기때문에 입력하지않는다.
	--------------------------------------------
	student_no	| student_name | student_age
	--------------------------------------------
		  1		|	      개미	   |		12 
	--------------------------------------------
	*/
	public void insertStudent(Student stu) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw");
			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement("insert into student (student_name, student_age) values (?, ?)");
			
			pstmt.setString(1, stu.getStudentName());
			pstmt.setInt(2, stu.getStudentAge());
			
			pstmt.executeUpdate();
			System.out.println("실행 확인");
			
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} 
				catch (SQLException e) {
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
