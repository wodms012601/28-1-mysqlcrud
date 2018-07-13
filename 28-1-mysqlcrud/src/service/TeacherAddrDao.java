/*28th Choi Yun-Seok, 2018.07.11*/
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class TeacherAddrDao {
	
	public void updateTeacherAddr(TeacherAddr teacherAddr) { // 주소 수정 메서드
		Connection conn = null;
		PreparedStatement statement = null;

        try { // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

			statement = conn.prepareStatement("UPDATE teacher_addr SET teacher_addr_content=? WHERE teacher_no=?");
			statement.setString(1, teacherAddr. getTeacher_addr_content());
			statement.setInt(2, teacherAddr.getTeacher_no());
			

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
	
	public ArrayList<TeacherAddr> selectTeacherAddrList(int currentPage, int pagePerRow, String addrKeyword){ // like 연산자를 이용한 키워드 검색 및 리스트 메서드
		//조회된 데이터를 ArrayList타입으로 객체배열의 주소값이 담긴 ArrayList객체 주소값을 리턴하는 메서드
		ArrayList<TeacherAddr> teacherAddrList = new ArrayList<TeacherAddr>();
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;

		int firstPage = (currentPage-1)*pagePerRow;

        try { // 예외 발생 가능성이 있는 문장
				Database database = new Database();
				conn = database.databaseConnect();

			if(addrKeyword.equals("")) { // 키워드가 없을 경우
				statement = conn.prepareStatement("SELECT teacher_addr_no, teacher_no, teacher_addr_content FROM teacher_addr ORDER BY teacher_addr_no DESC LIMIT ?, ?");

				statement.setInt(1, firstPage);
				statement.setInt(2, pagePerRow);

			} else { // 키워드가 있을 경우
				statement = conn.prepareStatement("SELECT teacher_addr_no, teacher_no, teacher_addr_content FROM teacher_addr WHERE teacher_addr_content LIKE ? ORDER BY teacher_addr_no DESC LIMIT ?, ?");

				statement.setString(1, "%"+addrKeyword+"%");
				statement.setInt(2, firstPage);
				statement.setInt(3, pagePerRow);

			}

				resultset = statement.executeQuery();

			while(resultset.next()) {
				TeacherAddr teacherAddr = new TeacherAddr();
				teacherAddr.setTeacher_addr_no(resultset.getInt("teacher_addr_no"));
				teacherAddr.setTeacher_no(resultset.getInt("teacher_no"));
				teacherAddr.setTeacher_addr_content(resultset.getString("teacher_addr_content"));
				teacherAddrList.add(teacherAddr);
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
		return teacherAddrList; // TeacherAddr 객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}
	
	public int Paging(int pagePerRow, String addrKeyword) { // 티쳐주소리스트 페이징 메서드
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;

		int totalRow = 0; // 모든 행 갯수의 변수
		int lastPage = 0; // 마지막 페이지 변수

		try{ // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

			statement = conn.prepareStatement("SELECT count(*) FROM teacher_addr WHERE teacher_addr_content LIKE ?");
			statement.setString(1, "%"+addrKeyword+"%");
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
	
	public TeacherAddr selectTeacherAddr(int TeacherAddrid) { // 주소 상세보기 메서드
	    Connection conn = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
	    TeacherAddr ta = null;

	    try { // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();
			
			statement = conn.prepareStatement("SELECT * FROM teacher_addr WHERE teacher_no=?");
			statement.setInt(1, TeacherAddrid);
			resultset = statement.executeQuery();

		if(resultset.next()) {
			ta = new TeacherAddr();
			ta.setTeacher_addr_no(resultset.getInt("teacher_addr_no"));
			ta.setTeacher_no(resultset.getInt("teacher_no"));
			ta.setTeacher_addr_content(resultset.getString("teacher_addr_content"));
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
	    return ta; // 티쳐주소 객체의 주소값을 리턴

	}

	public int insertTeacherAddr(TeacherAddr t) { // 주소 등록 메서드
		Connection conn = null;
		PreparedStatement pstmt = null;

		try{ // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

			pstmt = conn.prepareStatement("INSERT INTO teacher_addr(teacher_no,teacher_addr_content) VALUES (?,?)");
			pstmt.setInt(1, t.getTeacher_no());
			pstmt.setString(2, t.getTeacher_addr_content());

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
	
	public TeacherAddr selectForUpdateTeacherAddr(String teacherAddrId) { // 주소 수정 전 기존의 정보를 불러오는 메서드
		Connection conn = null;
		PreparedStatement statement = null;
		ResultSet resultset = null;
		TeacherAddr teacherAddr = null;

        try { // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

			statement = conn.prepareStatement("SELECT * FROM teacher_addr WHERE teacher_no=?");
			statement.setString(1, teacherAddrId);
			resultset = statement.executeQuery();

			if(resultset.next()) {
				teacherAddr = new TeacherAddr();
				teacherAddr.setTeacher_addr_no(resultset.getInt("teacher_addr_no"));
				teacherAddr.setTeacher_no(resultset.getInt("teacher_no"));
				teacherAddr.setTeacher_addr_content(resultset.getString("teacher_addr_content"));
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
		return teacherAddr; // 티쳐 객체의 주소값을 리턴
	}

	public TeacherAddr selectAddrCount(int teacherAddrId) { // 주소 버튼 유동 메서드
	    Connection conn = null;
	    PreparedStatement statement = null;
	    ResultSet resultset = null;
	    TeacherAddr teacherAddr = new TeacherAddr();
	    String sql = "SELECT * FROM teacher_addr WHERE teacher_no=?";
	    try { // 예외 발생 가능성이 있는 문장
			Database database = new Database();
			conn = database.databaseConnect();

	        statement = conn.prepareStatement(sql);
	        statement.setInt(1, teacherAddrId);
	        resultset = statement.executeQuery();
	        
			if(resultset.next()) {
				teacherAddr.setTeacher_addr_no(resultset.getInt("teacher_addr_no"));
				teacherAddr.setTeacher_no(resultset.getInt("teacher_no"));
				teacherAddr.setTeacher_addr_content(resultset.getString("teacher_addr_content"));
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
	    return teacherAddr;
	}
}