//탁재은, 2018.07.02
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentAddrDao {
	
	//db.학생주소테이블에 데이터 저장
	public void insertStudentAddr(StudentAddr addr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement("insert into student_addr (student_no, student_addr_content) values (?, ?)"); //쿼리문준비
			
			pstmt.setInt(1, addr.getStudentNo());
			pstmt.setString(2, addr.getStudentAddrContent());
			
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
	student_addr_no | student_no | student_addr_content
	--------------------------------------------
	 	1 |	 17	 |	전주싱
	--------------------------------------------
	 	2 |	 18	 |	서울시
	--------------------------------------------
	 	3 |	 19	 |	부산시
	--------------------------------------------
	 	4 |	 20	 |	대전시
	--------------------------------------------
	 	5 |	 21	 |	광주시
	--------------------------------------------
	 	6 |	 22	 |	수원시
	--------------------------------------------
	*/
	//주소리스트 작업
	public StudentAddr selectStudentAddr(int studentNo) {
		StudentAddr studentAddr = new StudentAddr(); //StudentAddr클래스를 통해 객체를 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결

			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement("select student_addr_no, student_no, student_addr_content from student_addr where student_no=?"); //쿼리문준비
			
			pstmt.setInt(1, studentNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				studentAddr.setStudentAddrNo(rs.getInt("student_addr_no")); //ResultSet객체에서 꺼내온 데이터들을 studentAddr객체참조변수를 통해 객체 내에 값을 대입 
				studentAddr.setStudentNo(rs.getInt("student_no"));
				studentAddr.setStudentAddrContent(rs.getString("student_addr_content"));
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
		return studentAddr;
	}
	
	//학생주소 페이징 작업
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
			
			pstmt = conn.prepareStatement("select count(*) from student_addr"); //쿼리문준비
			
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
	
	//학생 테이블 데이터 수정
	public void updateStudentAddr(StudentAddr addr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement("update student_addr set student_addr_content=? where student_no=?"); //쿼리문준비
			
			pstmt.setString(1, addr.getStudentAddrContent());
			pstmt.setInt(2, addr.getStudentNo());
			
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
	
	//학생주소 데이터 삭제
	public void deleteStudentAddr(int studentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement("delete from student_addr where student_no=?"); //쿼리문준비
			
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