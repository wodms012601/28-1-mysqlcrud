//탁재은, 2018.07.09
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StudentScoreDao {
	
	//db의 학생점수 테이블에 학생점수 저장
	public void insertScore(StudentScore studentScore) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//학생점수 테이블에 학생번호와 점수를 저장하는 쿼리문 준비
			pstmt = conn.prepareStatement("insert into student_score (student_no, score) values (?, ?)");
			
			pstmt.setInt(1, studentScore.getStudent_no()); //학생번호
			pstmt.setInt(2, studentScore.getScore()); //학생점수
			
			pstmt.executeUpdate(); //쿼리문 실행
			
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
	
	//점수 테이블과 학생 테이블 조인해서 리스트화
	/*
	---------------------------------------------------------------
	student_no | student_name | student_age	|	score
	---------------------------------------------------------------
	 	21 |	 탁재은	 |	23	|	95
	---------------------------------------------------------------
	 	20 |	 박씨	 |	26	|	100
	---------------------------------------------------------------
	*/
	public ArrayList<StudentAndScore> studentScoreJoin(){
		ArrayList<StudentAndScore> studentJoin = new ArrayList<StudentAndScore>(); //join한 데이터들을 담은 객체의 주소값을 저장하기위한 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=utf-8", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//점수테이블과 학생테이블을 조인(join)해서 두 테이블의 컬럼값들을 리스트 처리할수있도록 쿼리문 준비
			pstmt = conn.prepareStatement("select student.student_no, student.student_name, student.student_age, student_score.score from student_score inner join student on student_score.student_no=student.student_no");
			
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {
				Student student = new Student(); //학생 테이블의 데이터를 저장하기위한 학생 객체
				student.setStudentNo(rs.getInt("student.student_no")); //학생번호
				student.setStudentName(rs.getString("student.student_name")); //학생이름
				student.setStudentAge(rs.getInt("student.student_age")); //학생나이
				
				StudentScore studentScore = new StudentScore(); //점수 테이블의 데이터를 저장하기위한 점수 객체
				studentScore.setScore(rs.getInt("student_score.score")); //학생점수
				
				StudentAndScore studentAndScore = new StudentAndScore(); //학생 객체와 점수 객체의 주소값을 저장하는 조인객체
				studentAndScore.setStudent(student); //학생 객체
				studentAndScore.setStudentScore(studentScore); //점수 객체
				
				studentJoin.add(studentAndScore); //한번씩 반복될때마다 조인객체의 주소값을 인덱스에 저장
			}
			
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
		return studentJoin; //조인객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}
	
	public ArrayList<StudentAndScore> selectStudentListAboveAvg(){
		ArrayList<StudentAndScore> list = new ArrayList<StudentAndScore>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=utf-8";
		String user = "dev28id";
		String password = "dev28pw";
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			
			pstmt = conn.prepareStatement(sql);
			
			
			
			
		} catch {
			
		} finally {
			
		}
		return list;
	}
	
	public int selectScoreAvg() {
		//평균점수 구하는 쿼리문
		return 0;
	}
}
