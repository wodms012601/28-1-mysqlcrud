/*28th Choi Yun-Seok, 2018.07.9*/
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TeacherDao {
	
	public ArrayList<Teacher> selectTeacherByPage(int currentPage, int pagePerRow, String keyword){
		ArrayList<Teacher> teacherList = new ArrayList<Teacher>();
		Connection connection = null;
        PreparedStatement statement = null;
		ResultSet resultset = null;
		
		int firstPage = (currentPage-1)*pagePerRow;
		
        try { // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");
			 
			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";
			
			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);
		
			System.out.println("데이터 베이스 연결");
			
			if(keyword.equals("")) { 
				statement = connection.prepareStatement("SELECT teacher_no, teacher_name, teacher_age FROM teacher ORDER BY teacher_no LIMIT ?, ?");
				
				statement.setInt(1, firstPage);
				statement.setInt(2, pagePerRow);
				
			} else {
				statement = connection.prepareStatement("SELECT teacher_no, teacher_name, teacher_age FROM teacher where teacher_name LIKE ? ORDER BY teacher_no LIMIT ?, ?");
				
				statement.setString(1, "%"+keyword+"%");
				statement.setInt(2, firstPage);
				statement.setInt(3, pagePerRow);

			}
			
			resultset = statement.executeQuery();
			
			while(resultset.next()) {
                Teacher teacher = new Teacher();
                teacher.setTeacher_no(resultset.getInt("teacher_no"));
                teacher.setTeacherName(resultset.getString("teacher_name"));
                teacher.setTeacherAge(resultset.getInt("teacher_age"));
                teacherList.add(teacher);
			}
		} catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return teacherList;
	}
	
	public void updateTeacher(Teacher t) {
		Connection connection = null;
        PreparedStatement statement = null;
        
        try { // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");
			 
			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";
			
			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);
		
			System.out.println("데이터 베이스 연결");
		
			statement = connection.prepareStatement("UPDATE teacher SET teacher_name=?,teacher_age=? WHERE teacher_no=?");
			statement.setString(1, t.getTeacherName());
			statement.setInt(2, t.getTeacherAge());
			statement.setInt(3, t.getTeacher_no());
		
			statement.executeUpdate();
		
		} catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}		
	}
	
	public Teacher selectForUpdateTeacher(String teacherId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultset = null;
        Teacher t = null;
              
        try { // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");
			 
			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";
			
			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);
		
			System.out.println("데이터 베이스 연결");
		
			statement = connection.prepareStatement("SELECT * FROM teacher WHERE teacher_no=?");
			statement.setString(1, teacherId);
			resultset = statement.executeQuery();
			
			if(resultset.next()) {
	            t = new Teacher();
	            t.setTeacher_no(resultset.getInt("teacher_no"));
	            t.setTeacherName(resultset.getString("teacher_name"));
	            t.setTeacherAge(resultset.getInt("teacher_age"));
			}
		} catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return t;
	}    
	
	public void deleteTeacher(String teacherId) {
		Connection connection = null;
	    PreparedStatement statement = null;
		
        try { // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");
			 
			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";
			
			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);
		
			System.out.println("데이터 베이스 연결");
		
			statement = connection.prepareStatement("DELETE FROM teacher WHERE teacher_no =?");
			statement.setString(1, teacherId);
			statement.executeUpdate();
		
		} catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}		
	}
		
	public int teacherPaging(int pagePerRow) {
		Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
		
		int totalRow = 0;
		int lastPage = 0;
		
		try{ // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");
			 
			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";		
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";
			
			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);
		
			System.out.println("데이터 베이스 연결");
			
			statement = connection.prepareStatement("SELECT count(*) FROM teacher");
			
			resultset = statement.executeQuery();
			if(resultset.next()) {
				totalRow = resultset.getInt("count(*)");
			}
			
			if(totalRow % pagePerRow == 0){
				lastPage = totalRow / pagePerRow;
			} else{
				lastPage = (totalRow / pagePerRow) + 1;
			}
		} catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return lastPage;
	}

	public int insertTeacher(Teacher t) {
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
		
		} catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장
			
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