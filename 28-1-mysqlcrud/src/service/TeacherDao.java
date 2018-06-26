/*������, 2018.06.26*/
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TeacherDao {
	
	public int insertTeacher(Teacher t) {
		// insertTeacher �޼��� ����
		// �Ű������� Teacher Ŭ���� Ÿ���� ������ �̸��� ���̸� ���� ��ü�� �ּҰ��� ���� ���� t
		// ���ϰ� int Ÿ��
		
		Connection con = null; 
		PreparedStatement pstmt = null;
		
		try{ // ���� �߻� ���ɼ��� �ִ� ����
			Class.forName("com.mysql.jdbc.Driver");
			 
			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";
			
			con = DriverManager.getConnection(URL, dbUserId, dbPassword);
		
			System.out.println("������ ���̽� ����");
		
			pstmt = con.prepareStatement("INSERT INTO teacher(teacher_name, teacher_age) VALUES (?,?)");
			pstmt.setString(1, t.getTeacherName());
			pstmt.setInt(2, t.getTeacherAge());
			
			pstmt.executeUpdate();
		
		}catch(SQLException | ClassNotFoundException a) { // ���� Ÿ�԰� �Ű����� ��
			System.out.println(a.getMessage() + "<-- catch");
			
		}finally{ // �׻� ������ �ʿ䰡 �ִ� ����
			
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