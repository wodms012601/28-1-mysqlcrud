//탁재은, 2018.07.02
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StudentDao {
	
	/*db연결 및 학생 테이블에 데이터 상입
	매개변수는 stu객체참조변수로서 stu를 통해 학생데이터를 가져온다.
	insert만 하기때문에 리턴은 사용하지않는다.
	student_no는 기본값으로 auto_increment를 주었기때문에 입력하지않는다.
	--------------------------------------------
	student_no | student_name | student_age
	--------------------------------------------
	 	1 |	 개미	 |	1212
	--------------------------------------------
	*/
	public void insertStudent(Student stu) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement("insert into student (student_name, student_age) values (?, ?)"); //쿼리문준비
			
			pstmt.setString(1, stu.getStudentName());
			pstmt.setInt(2, stu.getStudentAge());
			
			pstmt.executeUpdate(); //쿼리문 실행
			System.out.println("실행 확인");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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
	
	/*
	--------------------------------------------
	student_no | student_name | student_age
	--------------------------------------------
	 	1 |	 개미	 |	1212
	--------------------------------------------
	 	2 |	 베짱이	 |	3
	--------------------------------------------
	 	3 |	 솔라	 |	28
	--------------------------------------------
	 	4 |	 문별	 |	27
	--------------------------------------------
	 	5 |	 휘인	 |	24
	--------------------------------------------
	 	6 |	 화사	 |	24
	--------------------------------------------
	*/
	//리스트 작업
	public ArrayList<Student> selectMemberByPage(int currentPage, int pagePerRow){
		ArrayList<Student> list = new ArrayList<Student>(); //ArrayList클래스를 통해 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결

			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement("select student_no, student_name, student_age from student order by student_no limit ?, ?"); //쿼리문준비
			
			pstmt.setInt(1, startPage);
			pstmt.setInt(2, pagePerRow);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			while(rs.next()) {
				Student student = new Student(); //Student클래스를 통해 객체를 생성 후 ResultSet객체에서 꺼내온 데이터들을 student객체참조변수를 통해 객체 내에 값을 대입 
				student.setStudentNo(rs.getInt("student_no"));
				student.setStudentName(rs.getString("student_name"));
				student.setStudentAge(rs.getInt("student_age"));
				
				list.add(student); //각 객체의 주소값을 배열의 인덱스에 추가
			}
			
		} catch (ClassNotFoundException e) { //예외가 일어났을경우의 처리
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { //모든 처리가 끝나면 반드시 나중에 열린 객체 순서대로 닫아준다.
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
		return list;
	}
	
	//페이징 작업
	public int paging(int pagePerRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement("select count(*) from student"); //쿼리문준비
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				//전체 행의 갯수를 totalRow에 대입
				totalRow = rs.getInt("count(*)");
			}
			
			if(totalRow % pagePerRow == 0){
				lastPage = totalRow / pagePerRow;
			} else{
				lastPage = (totalRow / pagePerRow) + 1;
			}
			
		} catch (ClassNotFoundException e) { //예외가 일어났을경우의 처리
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally { //모든 처리가 끝나면 반드시 나중에 열린 객체 순서대로 닫아준다.
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
		return lastPage;
	}
}
