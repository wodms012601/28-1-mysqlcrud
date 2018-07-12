/*28th Choi Yun-Seok, 2018.07.10*/
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TeacherScoreDao {

	public int selectScoreAvg() { // 평균점수를 구하는 메서드
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet resultSet = null;
		int AVG = 0;

		try{ // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");

			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";		
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";
			String sql = "SELECT AVG(score) FROM teacher_score ORDER BY score DESC";

			conn = DriverManager.getConnection(URL, dbUserId, dbPassword);

			System.out.println("데이터 베이스 연결");

			stmt = conn.prepareStatement(sql);

			resultSet = stmt.executeQuery();

			while(resultSet.next()) {
				AVG = resultSet.getInt("AVG(score)");
			}

		} catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");

		} finally{ // 항상 수행할 필요가 있는 문장

			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return AVG; // 평균점수 값을 담은 변수 리턴
	}

	public ArrayList<TeacherAndScore> selectTeacherListAboveAVG(int beginRow, int pagePerRow) { // 페이징,평균점수 이상인 사람들을 구하는 메서드
		ArrayList<TeacherAndScore> list = new ArrayList<TeacherAndScore>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet resultSet = null;
		String sql = "SELECT t.teacher_no, t.teacher_name, t.teacher_age, ts.score FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no WHERE score >= (SELECT AVG(score) FROM teacher_score) ORDER BY ts.score DESC LIMIT ?, ?";

		try{ // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");

			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";

			conn = DriverManager.getConnection(URL, dbUserId, dbPassword);

			System.out.println("데이터 베이스 연결");

			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, pagePerRow);

			resultSet = stmt.executeQuery();

			while(resultSet.next()) {
				Teacher teacher = new Teacher();
				teacher.setTeacher_no(resultSet.getInt("t.teacher_no"));
				teacher.setTeacherName(resultSet.getString("t.teacher_name"));
				teacher.setTeacherAge(resultSet.getInt("t.teacher_age"));

				TeacherScore teacherScore = new TeacherScore();
				teacherScore.setScore(resultSet.getInt("ts.score"));

				TeacherAndScore teacherAndScore = new TeacherAndScore();
				teacherAndScore.setTeacher(teacher);
				teacherAndScore.setTeacherScore(teacherScore);
				
				list.add(teacherAndScore);
			}
		} catch(SQLException | ClassNotFoundException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");

		} finally{ // 항상 수행할 필요가 있는 문장

			try {
				if(stmt != null) stmt.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return list; // TeacherAndScore 객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}

	public int selectTotalTeacherCountJoin() { // 조인 리스트 카운트 메서드
	    int rowCount = 0;
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
	    String sql = "SELECT COUNT(*) FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no WHERE score >= (SELECT AVG(score) FROM teacher_score)";
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

	public ArrayList<TeacherAndScore> selectTeacherAndScored(int beginRow, int pagePerRow) { //teacher테이블과 teacher_score테이블의 데이터를 조인/조회/페이징
	//조회된 데이터를 ArrayList타입으로 객체배열의 주소값이 담긴 ArrayList객체 주소값을 리턴하는 메서드

		Connection connection = null; 
		PreparedStatement statement = null;
		ResultSet resultSet = null;

		ArrayList<TeacherAndScore> arraylist = new ArrayList<TeacherAndScore>();
		String sql = "SELECT ts.teacher_score_no, ts.teacher_no, t.teacher_name, t.teacher_age, ts.score FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no ORDER BY ts.score DESC LIMIT ?, ? ";

		try{ // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");

			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";		
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";

			connection = DriverManager.getConnection(URL, dbUserId, dbPassword);

			System.out.println("데이터 베이스 연결");

			statement = connection.prepareStatement(sql);
			statement.setInt(1, beginRow);
			statement.setInt(2, pagePerRow);

			resultSet = statement.executeQuery();

			while(resultSet.next()){

				Teacher teacher = new Teacher();
				teacher.setTeacherName(resultSet.getString("t.teacher_name"));
				teacher.setTeacherAge(resultSet.getInt("t.teacher_age"));

				TeacherScore teacherScore = new TeacherScore();
				teacherScore.setTeacherNo(resultSet.getInt("ts.teacher_no"));
				teacherScore.setScore(resultSet.getInt("ts.score"));

				TeacherAndScore teacherAndScore = new TeacherAndScore();
				teacherAndScore.setTeacher(teacher);
				teacherAndScore.setTeacherScore(teacherScore);

				arraylist.add(teacherAndScore);

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
			return arraylist; // TeacherAndScore 객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}

	public int selectTotalTeacherCountJoin2() { // 리스트  페이징 메서드
	    int rowCount = 0;
	    Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
	    String sql = "SELECT COUNT(*) FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no";
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

	public int insertTeacherScore(TeacherScore teacherScore) { // 점수 등록 메서드
		Connection con = null;
		PreparedStatement pstmt = null;

		try{ // 예외 발생 가능성이 있는 문장
			Class.forName("com.mysql.jdbc.Driver");

			String URL = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";		
			String dbUserId = "dev28id";
			String dbPassword = "dev28pw";

			con = DriverManager.getConnection(URL, dbUserId, dbPassword);

			System.out.println("데이터 베이스 연결");

			pstmt = con.prepareStatement("INSERT INTO teacher_score(teacher_no, score) VALUES (?,?)");
			pstmt.setInt(1, teacherScore.getTeacherNo());
			pstmt.setInt(2, teacherScore.getScore());

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