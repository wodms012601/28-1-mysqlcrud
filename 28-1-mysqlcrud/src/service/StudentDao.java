//탁재은, 2018.07.09
package service;

import java.sql.Connection;
import java.sql.DriverManager;
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
	//db의 학생테이블에 데이터 저장 및 주소테이블의 student_no컬럼에 학생테이블의 student_no값을 저장하기위해 학생번호 검색
	public Student insertStudent(Student stu) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//학생 테이블에서 학생 이름과 학생 번호를 저장하기위한 쿼리문 준비
			pstmt = conn.prepareStatement("insert into student (student_name, student_age) values (?, ?)");
			
			/*각 테이블의 기본키를 auto_increment로 주었기때문에
			학생테이블에 먼저 데이터를 입력한 후 추가된 auto_increment를
			select문으로 받아 저장했습니다.*/
			//학생 테이블의 학생이름을 통해 학생 번호를 검색하는 쿼리문 준비
			pstmt2 = conn.prepareStatement("select student_no from student where student_name=?");
			
			pstmt.setString(1, stu.getStudentName());
			pstmt.setInt(2, stu.getStudentAge());
			
			pstmt2.setString(1, stu.getStudentName());
			
			pstmt.executeUpdate(); //쿼리문 실행
			System.out.println("학생테이블저장");
			
			rs = pstmt2.executeQuery(); //쿼리문 실행
			System.out.println("학생테이블select");
			
			if(rs.next()) {
				stu.setStudentNo(rs.getInt("student_no")); //넘버데이터 가져와서 변수에 저장
				System.out.println(stu.getStudentNo() + "<--학생넘버");
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt2 != null) {
				try {
					pstmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
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
		return stu;
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
	public ArrayList<Student> selectStudentByPage(int currentPage, int pagePerRow, String word){
		ArrayList<Student> studentList = new ArrayList<Student>(); //ArrayList클래스를 통해 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			if(word.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//학생 테이블에서 학생번호와 학생이름, 학생나이를 검색하는 쿼리문 준비(조건 : 학생번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select student_no, student_name, student_age from student order by student_no desc limit ?, ?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//학생 테이블에서 학생번호와 학생이름, 학생나이를 검색하는 쿼리문 준비(조건 : 학생이름컬럼에서 지정한 문자가 들어가있는 열을 검색)
				pstmt = conn.prepareStatement("select student_no, student_name, student_age from student where student_name like ? order by student_no desc limit ?, ?");
				
				pstmt.setString(1, "%"+word+"%");
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
		return studentList;
	}
	
	//학생페이징 작업
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
			
			//학생 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from student");
			
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
	
	//학생이름, 나이를 수정하기위해 리스트에 저장되어있는 데이터 찾기
	public Student selectStudent(int studentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Student student = new Student(); //Student클래스를 통해 객체를 생성
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//학생테이블의 학생번호를 통해 학생이름과 학생나이를 검색하는 쿼리문 준비
			pstmt = conn.prepareStatement("select student_name, student_age from student where student_no=?");
			
			pstmt.setInt(1, studentNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				student.setStudentName(rs.getString("student_name")); //ResultSet객체에서 꺼내온 데이터들을  학생 객체의 주소값을 통해 데이터 저장 
				student.setStudentAge(rs.getInt("student_age"));
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
		return student; //학생 객체의 주소값을 리턴값으로한다
	}
	
	//학생 테이블 데이터 수정
	public void updateStudent(Student stu) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//학생 테이블의 학생번호를 통해 학생이름과 학생나이 데이터를 수정하는 쿼리문 준비
			pstmt = conn.prepareStatement("update student set student_name=?, student_age=? where student_no=?");
			
			pstmt.setString(1, stu.getStudentName()); //학생이름
			pstmt.setInt(2, stu.getStudentAge()); //학생나이
			pstmt.setInt(3, stu.getStudentNo()); //학생번호
			
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
	
	//학생 데이터 삭제
	public void deleteStudent(int studentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//학생 테이블에서 학생번호가 들어간 행을 전체 삭제
			pstmt = conn.prepareStatement("delete from student where student_no=?");
			
			pstmt.setInt(1, studentNo);
			
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
}
