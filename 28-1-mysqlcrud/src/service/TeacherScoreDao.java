/*28th Choi Yun-Seok, 2018.07.10*/
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TeacherScoreDao {
	
	public ArrayList<TeacherAndScore> teacherScoreJoin(int currentPage, int pagePerRow, String scoreKeyword){ // like 연산자를 이용한 키워드 검색 및 리스트 메서드
		//조회된 데이터를 ArrayList타입으로 객체배열의 주소값이 담긴 ArrayList객체 주소값을 리턴하는 메서드
		ArrayList<TeacherAndScore> teacherScoreList = new ArrayList<TeacherAndScore>();
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;

		int firstPage = (currentPage-1)*pagePerRow;

        try { // 예외 발생 가능성이 있는 문장
				Database database = new Database();
				conn = database.databaseConnect();

			if(scoreKeyword.equals("")) { // 키워드가 없을 경우
				statement = conn.prepareStatement("SELECT ts.teacher_score_no, ts.teacher_no, t.teacher_name, t.teacher_age, ts.score FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no ORDER BY ts.score DESC LIMIT ?, ? ");

				statement.setInt(1, firstPage);
				statement.setInt(2, pagePerRow);

			} else { // 키워드가 있을 경우
				statement = conn.prepareStatement("SELECT ts.teacher_score_no, ts.teacher_no, t.teacher_name, t.teacher_age, ts.score FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no WHERE ts.score LIKE ? ORDER BY ts.score DESC LIMIT ?, ? ");
				statement.setString(1, "%"+scoreKeyword+"%");
				statement.setInt(2, firstPage);
				statement.setInt(3, pagePerRow);

			}

				resultSet = statement.executeQuery();

			while(resultSet.next()) {
				Teacher teacher = new Teacher();
				teacher.setTeacherName(resultSet.getString("t.teacher_name"));
				teacher.setTeacherAge(resultSet.getInt("t.teacher_age"));

				TeacherScore teacherScore = new TeacherScore();
				teacherScore.setTeacherNo(resultSet.getInt("ts.teacher_no"));
				teacherScore.setScore(resultSet.getInt("ts.score"));

				TeacherAndScore teacherAndScore = new TeacherAndScore();
				teacherAndScore.setTeacher(teacher);
				teacherAndScore.setTeacherScore(teacherScore);

				teacherScoreList.add(teacherAndScore);
			}
		} catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(statement != null) statement.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return teacherScoreList; // TeacherAndScore 객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}
	
	public int paging(int pagePerRow, String scoreKeyword) { // 티쳐점수리스트 페이징 메서드
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;

		int totalRow = 0; // 모든 행 갯수의 변수
		int lastPage = 0; // 마지막 페이지 변수

		try{ // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();
			statement = conn.prepareStatement("SELECT count(*) FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no WHERE ts.score LIKE ?");
			statement.setString(1, "%"+scoreKeyword+"%");
			resultset = statement.executeQuery();

			if(resultset.next()) {
				totalRow = resultset.getInt("count(*)");
			}
			
			if(totalRow % pagePerRow == 0){
				lastPage = totalRow / pagePerRow;
			} else{
				lastPage = (totalRow / pagePerRow) + 1;
			}
		} catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장

			try {
				if(statement != null) statement.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return lastPage;
	}

	public int selectScoreAvg() { // 평균점수를 구하는 메서드
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet resultSet = null;
		int AVG = 0;

		try{ // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();
			
			String sql = "SELECT AVG(score) FROM teacher_score ORDER BY score DESC";

			System.out.println("데이터 베이스 연결");

			stmt = conn.prepareStatement(sql);

			resultSet = stmt.executeQuery();

			while(resultSet.next()) {
				AVG = resultSet.getInt("AVG(score)");
			}

		} catch(SQLException a) { // 예외 타입과 매개변수 명
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

	public ArrayList<TeacherAndScore> selectTeacherListAboveAvg(int currentPage, int pagePerRow){
		//조회된 데이터를 ArrayList타입으로 객체배열의 주소값이 담긴 ArrayList객체 주소값을 리턴하는 메서드
		ArrayList<TeacherAndScore> teacherAndScoreList = new ArrayList<TeacherAndScore>();
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;

		int firstPage = (currentPage-1)*pagePerRow;

        try { // 예외 발생 가능성이 있는 문장
				Database database = new Database();
				conn = database.databaseConnect();

				statement = conn.prepareStatement("SELECT t.teacher_no, t.teacher_name, t.teacher_age, ts.score FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no WHERE score >= (SELECT AVG(score) FROM teacher_score) ORDER BY ts.score DESC LIMIT ?, ?");

				statement.setInt(1, firstPage);
				statement.setInt(2, pagePerRow);

				resultSet = statement.executeQuery();

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
				
				teacherAndScoreList.add(teacherAndScore);
			}
		} catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(statement != null) statement.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return teacherAndScoreList; // TeacherAndScore 객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}

	public int paging(int pagePerRow) { // 티쳐점수리스트 페이징 메서드
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;

		int totalRow = 0; // 모든 행 갯수의 변수
		int lastPage = 0; // 마지막 페이지 변수

		try{ // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();
			statement = conn.prepareStatement("SELECT count(*) FROM teacher_score ts INNER JOIN teacher t ON ts.teacher_no = t.teacher_no WHERE score >= (SELECT AVG(score) FROM teacher_score)");
			resultset = statement.executeQuery();

			if(resultset.next()) {
				totalRow = resultset.getInt("count(*)");
			}
			
			if(totalRow % pagePerRow == 0){
				lastPage = totalRow / pagePerRow;
			} else{
				lastPage = (totalRow / pagePerRow) + 1;
			}
		} catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");
			
		} finally{ // 항상 수행할 필요가 있는 문장

			try {
				if(statement != null) statement.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return lastPage;
	}

	public int insertScore(TeacherScore teacherScore) { // 점수 등록 메서드
		Connection conn = null;
		PreparedStatement pstmt = null;

		try{ // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

			pstmt = conn.prepareStatement("INSERT INTO teacher_score(teacher_no, score) VALUES (?,?)");
			pstmt.setInt(1, teacherScore.getTeacherNo());
			pstmt.setInt(2, teacherScore.getScore());

			pstmt.executeUpdate();

		} catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");

		} finally{ // 항상 수행할 필요가 있는 문장
			
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return 0;
	}
	
	public TeacherScore selectTeacherScore(int TeacherScoreId) { // 점수 상세보기 메서드
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		TeacherScore teacherScore = null;

		try { // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();
			
			statement = conn.prepareStatement("SELECT * FROM teacher_score WHERE teacher_no=?");
			statement.setInt(1, TeacherScoreId);
			resultset = statement.executeQuery();

		if(resultset.next()) {
			teacherScore = new TeacherScore();
			teacherScore.setTeacherScoreNo(resultset.getInt("teacher_score_no"));
			teacherScore.setTeacherNo(resultset.getInt("teacher_no"));
			teacherScore.setScore(resultset.getInt("score"));
		}
		} catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");

		} finally { // 항상 수행할 필요가 있는 문장

			try {
				if(statement != null) statement.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return teacherScore; // 티쳐점수 객체의 주소값을 리턴

	}
	
	public void updateTeacherScore(TeacherScore teacherScore) { // 점수 수정 메서드
		Connection conn = null;
		PreparedStatement statement = null;

        try { // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

			statement = conn.prepareStatement("UPDATE teacher_score SET score=? WHERE teacher_no=?");
			statement.setInt(1, teacherScore.getScore());
			statement.setInt(2, teacherScore.getTeacherNo());
			

			statement.executeUpdate();

		} catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");

		} finally{ // 항상 수행할 필요가 있는 문장

			try {
				if(statement != null) statement.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
	}
	
	public TeacherScore selectForUpdateTeacherScore(String teacherScoreId) { // 점수 수정 전 기존의 정보를 불러오는 메서드
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		TeacherScore teacherScore = null;

        try { // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

			statement = conn.prepareStatement("SELECT * FROM teacher_score WHERE teacher_no=?");
			statement.setString(1, teacherScoreId);
			resultset = statement.executeQuery();

			if(resultset.next()) {
				teacherScore = new TeacherScore();
				teacherScore.setTeacherScoreNo(resultset.getInt("teacher_score_no"));
				teacherScore.setTeacherNo(resultset.getInt("teacher_no"));
				teacherScore.setScore(resultset.getInt("score"));
			}
		} catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");

		} finally{ // 항상 수행할 필요가 있는 문장

			try {
				if(statement != null) statement.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
		}
		return teacherScore; // 티쳐 객체의 주소값을 리턴
	}
	
	public TeacherScore selectScoreCount(int teacherId) { // 점수 버튼 유동 메서드
	    Connection conn = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
	    TeacherScore teacherScore = new TeacherScore();
	    String sql = "SELECT teacher_score_no, teacher_no, score FROM teacher_score WHERE teacher_no=?";
	    try { // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

	        statement = conn.prepareStatement(sql);
	        statement.setInt(1, teacherId);
	        resultset = statement.executeQuery();
	        
			if(resultset.next()) {
				teacherScore.setTeacherScoreNo(resultset.getInt("teacher_score_no"));
				teacherScore.setTeacherNo(resultset.getInt("teacher_no"));
				teacherScore.setScore(resultset.getInt("score"));
			}
	    } catch(SQLException a) { // 예외 타입과 매개변수 명
			System.out.println(a.getMessage() + "<-- catch");

	    } finally {	// 항상 수행할 필요가 있는 문장

			try {
				if(statement != null) statement.close();
				if(conn != null) conn.close();
			}
			catch(SQLException a) {
				System.out.println(a.getMessage() + "<-- catch");
			}
	    }
	    return teacherScore;
	}
}