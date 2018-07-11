/*28th Choi Yun-Seok, 2018.07.11*/
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TeacherAddrDao {
	
	public TeacherAddr infoTeacherAddr(int TeacherAddrid) { // 주소 상세보기 메서드
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
	    TeacherAddr ta = null;

	    try {
			Class.forName("com.mysql.jdbc.Driver");

			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";

			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);

			System.out.println("데이터 베이스 연결");
			statement = connection.prepareStatement("SELECT * FROM teacher_addr WHERE teacher_no=?");
			statement.setInt(1, TeacherAddrid);
			resultset = statement.executeQuery();

		if(resultset.next()) {
			ta = new TeacherAddr();
			ta.setTeacher_addr_no(resultset.getInt("teacher_addr_no"));
			ta.setTeacher_no(resultset.getInt("teacher_no"));
			ta.setTeacher_addr_content(resultset.getString("teacher_addr_content"));
		}
		} catch(SQLException | ClassNotFoundException a) {
			System.out.println(a.getMessage() + "<-- catch");

	    } finally {

			try {
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
	    }
	    return ta;

	}

	public int selectTotalTeacherCountAddr() { // 주소 리스트 카운트 메서드
	    int rowCount = 0;
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
	    String sql = "SELECT COUNT(*) FROM teacher_addr";
	    try { // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");

			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";

			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);

			System.out.println("데이터 베이스 연결");

	        statement = connection.prepareStatement(sql);
	        resultset = statement.executeQuery();

	        if(resultset.next()) {
	            rowCount = resultset.getInt(1);
	        }
	    } catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");

	    } finally {	// 항상 수행할 필요가 있는 문장

			try {
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
	    }
	    return rowCount;
	}

	public ArrayList<TeacherAddr> selectTeacherAddr(int beginRow, int pagePerRow) { // 주소 리스트 페이징
		ArrayList<TeacherAddr> list = new ArrayList<TeacherAddr>();
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
	    String sql = "SELECT teacher_addr_no, teacher_no, teacher_addr_content FROM teacher_addr ORDER BY teacher_addr_no DESC LIMIT ?, ?";
	    try { // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");

			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";

			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);

			System.out.println("데이터 베이스 연결");

	        statement = connection.prepareStatement(sql);
	        statement.setInt(1, beginRow);
	        statement.setInt(2, pagePerRow);

	        resultset = statement.executeQuery();

	        while(resultset.next()) {
	            TeacherAddr teacheraddr = new TeacherAddr();
	            teacheraddr.setTeacher_addr_no(resultset.getInt("teacher_addr_no"));
	            teacheraddr.setTeacher_no(resultset.getInt("teacher_no"));
	            teacheraddr.setTeacher_addr_content(resultset.getString("teacher_addr_content"));
	            list.add(teacheraddr);
	        }
	    } catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch"); 

	    } finally {	// 항상 수행할 필요가 있는 문장
			try {
				if(statement != null) statement.close();
				if(connection != null) connection.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
	    }
	    return list;
	}

	public int insertTeacherAdd(TeacherAddr t) { // 주소 등록 메서드
		Connection con = null; 
		PreparedStatement pstmt = null;

		try{ // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");

			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";		
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";

			con = DriverManager.getConnection(URL, dbUserId, dbPassword);

			System.out.println("데이터 베이스 연결");

			pstmt = con.prepareStatement("INSERT INTO teacher_addr(teacher_no,teacher_addr_content) VALUES (?,?)");
			pstmt.setInt(1, t.getTeacher_no());
			pstmt.setString(2, t.getTeacher_addr_content());

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