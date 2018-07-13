//탁재은, 2018.07.09
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StudentDao {
	
	/*db연결 및 학생 테이블에 데이터 상입
	--------------------------------------------
	student_no | student_name | student_age
	--------------------------------------------
	 	1 |	 송원민	 |	25
	--------------------------------------------
	*/
	public void insertStudent(Student stu) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 테이블에서 학생 이름과 학생 번호를 저장하기위한 쿼리문 준비
			pstmt = conn.prepareStatement("insert into student (student_name, student_age) values (?, ?)");
			
			pstmt.setString(1, stu.getStudentName());
			pstmt.setInt(2, stu.getStudentAge());
			
			pstmt.executeUpdate(); //쿼리문 실행
			System.out.println("학생테이블저장");
		
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
	 	1 |	 송원민	 |	25
	--------------------------------------------
	 	2 |	 탁재은	 |	23
	--------------------------------------------
	 	3 |	 최윤석	 |	24
	--------------------------------------------
	 	4 |	 홍길동	 |	26
	--------------------------------------------
	 	5 |	 김길동	 |	28
	--------------------------------------------
	 	6 |	 이길이	 |	20
	--------------------------------------------
	*/
	//학생리스트 작업
	public ArrayList<Student> selectStudentByPage(int currentPage, int pagePerRow, String nameKeyword){
		ArrayList<Student> studentList = new ArrayList<Student>(); //ArrayList클래스를 통해 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			if(nameKeyword.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//학생 테이블에서 학생번호와 학생이름, 학생나이를 검색하는 쿼리문 준비(조건 : 학생번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select student_no, student_name, student_age from student order by student_no desc limit ?, ?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//학생 테이블에서 학생번호와 학생이름, 학생나이를 검색하는 쿼리문 준비(조건 : 학생이름컬럼에서 지정한 문자가 들어가있는 열을 검색)
				pstmt = conn.prepareStatement("select student_no, student_name, student_age from student where student_name like ? order by student_no desc limit ?, ?");
				
				pstmt.setString(1, "%"+nameKeyword+"%");
				pstmt.setInt(2, startPage);
				pstmt.setInt(3, pagePerRow);
			}
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			while(rs.next()) {
				Student student = new Student(); //Student클래스를 통해 객체를 생성 후 ResultSet객체에서 꺼내온 데이터들을 student객체참조변수를 통해 객체 내에 값을 대입 
				student.setStudentNo(rs.getInt("student_no")); //학생번호
				student.setStudentName(rs.getString("student_name")); //학생이름
				student.setStudentAge(rs.getInt("student_age")); //학생나이
				
				studentList.add(student); //각 객체의 주소값을 배열의 인덱스에 추가
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
		return studentList;
	}
	
	//학생페이징 작업
	public int paging(int pagePerRow, String nameKeyword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from student where student_name like ? ");
			
			pstmt.setString(1, "%"+nameKeyword+"%");
			
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
	
	//학생이름, 나이를 수정하기위해 리스트에 저장되어있는 데이터 찾기
	public Student selectStudent(int studentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Student student = new Student(); //Student클래스를 통해 객체를 생성
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생테이블의 학생번호를 통해 학생이름과 학생나이를 검색하는 쿼리문 준비
			pstmt = conn.prepareStatement("select student_name, student_age from student where student_no=?");
			
			pstmt.setInt(1, studentNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				student.setStudentName(rs.getString("student_name")); //ResultSet객체에서 꺼내온 데이터들을  학생 객체의 주소값을 통해 데이터 저장 
				student.setStudentAge(rs.getInt("student_age"));
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
		return student; //학생 객체의 주소값을 리턴값으로한다
	}
	
	//학생 테이블 데이터 수정
	public void updateStudent(Student stu) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 테이블의 학생번호를 통해 학생이름과 학생나이 데이터를 수정하는 쿼리문 준비
			pstmt = conn.prepareStatement("update student set student_name=?, student_age=? where student_no=?");
			
			pstmt.setString(1, stu.getStudentName()); //학생이름
			pstmt.setInt(2, stu.getStudentAge()); //학생나이
			pstmt.setInt(3, stu.getStudentNo()); //학생번호
			
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
	
	//학생 데이터 삭제
	public void deleteStudent(int studentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 테이블에서 학생번호가 들어간 행을 전체 삭제
			pstmt = conn.prepareStatement("delete from student where student_no=?");
			
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
