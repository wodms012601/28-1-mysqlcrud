//탁재은, 2018.07.12
package service;

import java.sql.Connection;
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
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생점수 테이블에 학생번호와 점수를 저장하는 쿼리문 준비
			pstmt = conn.prepareStatement("insert into student_score (student_no, score) values (?, ?)");
			
			pstmt.setInt(1, studentScore.getStudentNo()); //학생번호
			pstmt.setInt(2, studentScore.getScore()); //학생점수
			
			pstmt.executeUpdate(); //쿼리문 실행
			
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
	 	1 |	 송원민	 |	25	|	95
	---------------------------------------------------------------
	 	2 |	 탁재은	 |	23	|	94
	---------------------------------------------------------------
	 	3 |	 최윤석	 |	24	|	90
	---------------------------------------------------------------
	 	4 |	 홍길동	 |	26	|	85
	---------------------------------------------------------------
	 	5 |	 김길동	 |	28	|	80
	---------------------------------------------------------------
	 	6 |	 이길이	 |	20	|	97
	---------------------------------------------------------------
	*/
	public ArrayList<StudentAndScore> studentScoreJoin(int currentPage, int pagePerRow, String scoreKeyword){
		ArrayList<StudentAndScore> studentJoin = new ArrayList<StudentAndScore>(); //join한 데이터들을 담은 객체의 주소값을 저장하기위한 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			if(scoreKeyword.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//점수테이블과 학생테이블을 조인(join)해서 두 테이블의 컬럼값들을 리스트 처리할수있도록 쿼리문 준비(조건 : 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select student.student_no, student.student_name, student.student_age, student_score.score from student_score inner join student on student_score.student_no=student.student_no order by student_no desc limit ?, ?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//점수테이블과 학생테이블을 조인(join)해서 검색한결과의 값들을 리스트 처리할수있도록 쿼리문 준비(조건 : 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select student.student_no, student.student_name, student.student_age, student_score.score from student_score inner join student on student_score.student_no=student.student_no where score like ? order by student_no desc limit ?, ?");
				
				pstmt.setString(1, "%"+scoreKeyword+"%");
				pstmt.setInt(2, startPage);
				pstmt.setInt(3, pagePerRow);
			}
			
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
	
	//학생점수리스트 페이징 작업
	public int paging(int pagePerRow, String scoreKeyword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from student_score inner join student on student_score.student_no=student.student_no where score like ?");
			
			pstmt.setString(1, "%"+scoreKeyword+"%");
			
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
	
	//학생점수리스트 페이징 작업
	public int paging(int pagePerRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from student_score where score >= (select avg(score) from student_score)");
			
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
	
	//학생 테이블과 학생 점수 테이블을 조인해서 평균점수를 넘은 학생만 검색하는 메서드
	/*
	---------------------------------------------------------------
	student_no | student_name 	|	score
	---------------------------------------------------------------
	 	6 |	 이길이	 	|	97
	---------------------------------------------------------------
	 	1 |	 송원민	|	95
	---------------------------------------------------------------
	 	2 |	 탁재은	|	94
	---------------------------------------------------------------
	*/
	public ArrayList<StudentAndScore> selectStudentListAboveAvg(int currentPage, int pagePerRow){
		ArrayList<StudentAndScore> studentAvg = new ArrayList<StudentAndScore>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		//학생 테이블과 학생 점수 테이블을 조인해서 no와 점수, 이름을 검색하면서 평균 점수보다 높은 점수를 가진 학생만 출력하도록 조건을 주는 쿼리문 준비 (조건 : 점수가 가장 높은 학생이 맨 위로 지정한 숫자대로 테이블의 열을 보여준다)
		String sql = "select s.student_no, s.student_name, s.student_age, ss.score from student s inner join student_score ss on s.student_no=ss.student_no where score >= (select avg(score) from student_score) order by score desc limit ?, ?";
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement(sql); //쿼리문 준비
			
			pstmt.setInt(1, startPage); //시작지점
			pstmt.setInt(2, pagePerRow); //열의 갯수
			
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {
				Student student = new Student(); //학생 테이블의 데이터를 저장하기위한 학생 객체
				student.setStudentNo(rs.getInt("s.student_no")); //학생번호
				student.setStudentName(rs.getString("s.student_name")); //학생이름
				student.setStudentAge(rs.getInt("s.student_age")); //학생나이
				
				StudentScore studentScore = new StudentScore(); //점수 테이블의 데이터를 저장하기위한 점수 객체
				studentScore.setScore(rs.getInt("ss.score")); //학생점수
				
				StudentAndScore studentAndScore = new StudentAndScore(); //학생 객체와 점수 객체의 주소값을 저장하는 조인객체
				studentAndScore.setStudent(student); //학생 객체
				studentAndScore.setStudentScore(studentScore); //점수 객체
				
				studentAvg.add(studentAndScore); //한번씩 반복될때마다 조인객체의 주소값을 인덱스에 저장
			}
			
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
		return studentAvg; //조인객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}
	
	//학생 점수테이블의 평균점수를 구하는 메서드
	public int selectScoreAvg() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int avg = 0; //평균점수를 저장할 변수
		
		//학생 점수테이블에서 집합함수를 사용해서 평균점수를 검색
		String sql = "select avg(score) from student_score order by score desc";
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement(sql); //쿼리문 준비
			
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {
				avg = rs.getInt("avg(score)");
			}
			
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
		return avg; //검색한 평균점수의 값을 담은 변수를 리턴
	}
	
	/*
	--------------------------------------------
	student_score_no | student_no | score
	--------------------------------------------
	 	1 |	 1	 |	95
	--------------------------------------------
	*/
	//학생점수 테이블에서 한명의 학생점수 검색
	public StudentScore selectStudentScore(int studentNo) {
		StudentScore studentScore = new StudentScore(); //StudentScore클래스를 통해 객체를 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생점수 테이블에서 학생번호를 통해 점수번호, 학생번호, 학생점수 데이터를 찾는 쿼리문 준비
			pstmt = conn.prepareStatement("select student_score_no, student_no, score from student_score where student_no=?");
			
			pstmt.setInt(1, studentNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				studentScore.setStudentScoreNo(rs.getInt("student_score_no")); //ResultSet객체에서 꺼내온 데이터들을  학생점수 객체의 주소값을 통해 데이터 저장 
				studentScore.setStudentNo(rs.getInt("student_no"));
				studentScore.setScore(rs.getInt("score"));
			}
			
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
		return studentScore; //학생점수 객체의 주소값을 리턴값으로한다
	}
	
	//학생점수 테이블 데이터 수정
	public void updateStudentScore(StudentScore stuScore) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생점수 테이블의 학생번호를 통해 학생점수를 수정하는 쿼리문 준비
			pstmt = conn.prepareStatement("update student_score set score=? where student_no=?");
			
			pstmt.setInt(1, stuScore.getScore()); //학생점수
			pstmt.setInt(2, stuScore.getStudentNo()); //학생번호
			
			pstmt.executeUpdate(); //쿼리문 실행

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
	
	//학생점수 데이터 삭제
	public void deleteStudentScore(int studentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 테이블에서 학생번호가 들어간 행을 전체 삭제
			pstmt = conn.prepareStatement("delete from student_score where student_no=?");
			
			pstmt.setInt(1, studentNo);
			
			pstmt.executeUpdate(); //쿼리문 실행

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
}
