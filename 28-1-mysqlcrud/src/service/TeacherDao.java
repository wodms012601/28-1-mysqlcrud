/*28th Choi Yun-Seok, 2018.07.11*/
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TeacherDao {

	public ArrayList<Teacher> selectTeacherByPage(int currentPage, int pagePerRow, String keyword){ // like 연산자를 이용한 키워드 검색 및 리스트 메서드
		//조회된 데이터를 ArrayList타입으로 객체배열의 주소값이 담긴 ArrayList객체 주소값을 리턴하는 메서드
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

			if(keyword.equals("")) { // 키워드가 없을 경우
				statement = connection.prepareStatement("SELECT teacher_no, teacher_name, teacher_age FROM teacher ORDER BY teacher_no LIMIT ?, ?");

				statement.setInt(1, firstPage);
				statement.setInt(2, pagePerRow);

			} else { // 키워드가 있을 경우
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
		return teacherList; // Teacher 객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}

	public void updateTeacher(Teacher t) { // 정보 수정 메서드
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

	public Teacher selectForUpdateTeacher(String teacherId) { // 정보 수정 전 기존의 정보를 불러오는 메서드
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
		return t; // 티쳐 객체의 주소값을 리턴
	}

	public void deleteTeacher(String teacherId) { // 정보 삭제 메서드
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

	public int teacherPaging(int pagePerRow) { // 티쳐리스트 페이징 메서드
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;

		int totalRow = 0; // 모든 행 갯수의 변수
		int lastPage = 0; // 마지막 페이지 변수

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

	public int insertTeacher(Teacher t) { // 정보 등록 메서드
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