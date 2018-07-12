//탁재은, 2018.07.09
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StudentAddrDao {
	
	//db의 학생주소테이블에 데이터 저장
	public void insertStudentAddr(StudentAddr addr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 주소 테이블에서 학생번호와 학생주소를 저장하는 쿼리문 준비
			pstmt = conn.prepareStatement("insert into student_addr (student_no, student_addr_content) values (?, ?)");
			
			pstmt.setInt(1, addr.getStudentNo());
			pstmt.setString(2, addr.getStudentAddrContent());
			
			pstmt.executeUpdate(); //쿼리문 실행
			System.out.println("실행 확인");
				
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
	 	1 |	 1	 |	전주시 덕진구
	--------------------------------------------
	 	2 |	 2	 |	전주시
	--------------------------------------------
	 	3 |	 3	 |	전주시
	--------------------------------------------
	 	4 |	 4	 |	서울시
	--------------------------------------------
	 	5 |	 5	 |	대전시
	--------------------------------------------
	 	6 |	 6	 |	부산
	--------------------------------------------
	*/
	//주소리스트 작업
	public ArrayList<StudentAddr> selectStudentAddrList(int currentPage, int pagePerRow, String word) {
		ArrayList<StudentAddr> studentAddrList = new ArrayList<StudentAddr>(); //학생 주소객체의 주소값을 저장할 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글

		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			if(word.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//학생주소 테이블에서 학생번호와 학생주소번호, 학생주소를 검색하는 쿼리문 준비(조건 : 학생번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select student_addr_no, student_no, student_addr_content from student_addr order by student_addr_no desc limit ?, ?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//학생 테이블에서 학생번호와 학생주소번호, 학생주소를 검색하는 쿼리문 준비(조건 : 학생이름컬럼에서 지정한 문자가 들어가있는 열을 검색)
				pstmt = conn.prepareStatement("select student_addr_no, student_no, student_addr_content from student_addr where student_addr_content like ? order by student_addr_no desc limit ?, ?");
				
				pstmt.setString(1, "%"+word+"%");
				pstmt.setInt(2, startPage);
				pstmt.setInt(3, pagePerRow);
			}

			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			while(rs.next()) {
				StudentAddr addr = new StudentAddr(); //ResultSet객체에서 꺼내온 데이터들을  학생주소 객체의 주소값을 통해 데이터 저장 
				addr.setStudentAddrNo(rs.getInt("student_addr_no")); //학생 주소번호
				addr.setStudentNo(rs.getInt("student_no")); //학생 번호
				addr.setStudentAddrContent(rs.getString("student_addr_content")); //학생 주소
				
				studentAddrList.add(addr); //한번씩 반복될때마다 학생 주소객체의 주소값을 인덱스에 저장
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
		return studentAddrList; //학생주소 객체의 주소값담은 배열객체의 주소값을 리턴
	}
	
	/*
	--------------------------------------------
	student_addr_no | student_no | student_addr_content
	--------------------------------------------
	 	1 |	 1	 |	전주시 덕진구
	--------------------------------------------
	*/
	//학생 주소테이블에서 한명의 학생 주소검색
	public StudentAddr selectStudentAddr(int studentNo) {
		StudentAddr studentAddr = new StudentAddr(); //StudentAddr클래스를 통해 객체를 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생주소 테이블에서 학생번호를 통해 학생주소번호, 학생번호, 학생주소 데이터를 찾는 쿼리문 준비
			pstmt = conn.prepareStatement("select student_addr_no, student_no, student_addr_content from student_addr where student_no=?");
			
			pstmt.setInt(1, studentNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				studentAddr.setStudentAddrNo(rs.getInt("student_addr_no")); //ResultSet객체에서 꺼내온 데이터들을  학생주소 객체의 주소값을 통해 데이터 저장 
				studentAddr.setStudentNo(rs.getInt("student_no"));
				studentAddr.setStudentAddrContent(rs.getString("student_addr_content"));
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
		return studentAddr; //학생주소 객체의 주소값을 리턴값으로한다
	}
	
	//학생주소 페이징 작업
	public int paging(int pagePerRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 주소테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from student_addr");
			
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
		return lastPage; //마지막 페이지의 결과값을 리턴
	}
	
	//학생주소 테이블 데이터 수정
	public void updateStudentAddr(StudentAddr addr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 주소테이블의 학생번호를 통해 학생주소 데이터를 수정하는 쿼리문 준비
			pstmt = conn.prepareStatement("update student_addr set student_addr_content=? where student_no=?");
			
			pstmt.setString(1, addr.getStudentAddrContent());
			pstmt.setInt(2, addr.getStudentNo());
			
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
	
	//학생주소 데이터 삭제
	public void deleteStudentAddr(int studentNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생주소테이블에서 학생번호가 들어간 행을 전체 삭제
			pstmt = conn.prepareStatement("delete from student_addr where student_no=?");
			
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