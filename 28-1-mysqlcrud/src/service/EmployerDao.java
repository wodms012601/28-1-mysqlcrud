//탁재은, 2018.07.12
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmployerDao {
	
	/*db연결 및 직원 테이블에 데이터 상입
	--------------------------------------------
	employer_no | employer_name | employer_age
	--------------------------------------------
	 	1 |	 최윤석	 |	24
	--------------------------------------------
	*/
	public void insertEmployer(Employer emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 테이블에서 직원 이름과 직원 번호를 저장하기위한 쿼리문 준비
			pstmt = conn.prepareStatement("insert into employer (employer_name, employer_age) values (?, ?)");
			
			pstmt.setString(1, emp.getEmployerName()); //직원 이름
			pstmt.setInt(2, emp.getEmployerAge()); //직원 나이
			
			pstmt.executeUpdate(); //쿼리문 실행
			System.out.println("직원테이블저장");
			
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
	employer_no | employer_name | employer_age
	--------------------------------------------
	 	1 |	 최윤석	 |	24
	--------------------------------------------
	 	2 |	 탁재은	 |	23
	--------------------------------------------
	 	3 |	 김준영	 |	25
	--------------------------------------------
	 	4 |	 김정연	 |	25
	--------------------------------------------
	 	5 |	 김문수	 |	26
	--------------------------------------------
	 	6 |	 이광재	 |	27
	--------------------------------------------
	*/
	//직원리스트 작업
	public ArrayList<Employer> selectEmployerByPage(int currentPage, int pagePerRow, String nameKeyword){
		ArrayList<Employer> employerList = new ArrayList<Employer>(); //ArrayList클래스를 통해 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			if(nameKeyword.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//직원 테이블에서 직원번호와 직원이름, 직원나이를 검색하는 쿼리문 준비(조건 : 직원번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select employer_no, employer_name, employer_age from employer order by employer_no desc limit ?, ?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//직원 테이블에서 직원번호와 직원이름, 직원나이를 검색하는 쿼리문 준비(조건 : 직원이름 컬럼에서 지정한 문자가 들어가있는 열을 검색)
				pstmt = conn.prepareStatement("select employer_no, employer_name, employer_age from employer where employer_name like ? order by employer_no desc limit ?, ?");
				
				pstmt.setString(1, "%"+nameKeyword+"%");
				pstmt.setInt(2, startPage);
				pstmt.setInt(3, pagePerRow);
			}
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			while(rs.next()) {
				Employer employer = new Employer(); //Employer클래스를 통해 객체를 생성 후 ResultSet객체에서 꺼내온 데이터들을 employer객체참조변수를 통해 객체 내에 값을 대입 
				employer.setEmployerNo(rs.getInt("employer_no"));
				employer.setEmployerName(rs.getString("employer_name"));
				employer.setEmployerAge(rs.getInt("employer_age"));
				
				employerList.add(employer); //각 객체의 주소값을 배열의 인덱스에 추가
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
		return employerList; //직원 객체의 주소값담은 배열객체의 주소값을 리턴
	}
	
	//직원리스트페이징 작업
	public int paging(int pagePerRow, String nameKeyword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from employer where employer_name like ? ");
			
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
	
	//직원주소를 수정하기위해 리스트에 저장되어있는 데이터 찾기
	public Employer selectEmployer(int employerNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Employer employer = new Employer(); //Employer클래스를 통해 객체를 생성
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원테이블의 직원번호를 통해 직원이름과 직원나이를 검색하는 쿼리문 준비
			pstmt = conn.prepareStatement("select employer_name, employer_age from employer where employer_no=?");
			
			pstmt.setInt(1, employerNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				employer.setEmployerName(rs.getString("employer_name")); //ResultSet객체에서 꺼내온 데이터들을 직원 객체의 주소값을 통해 데이터 저장 
				employer.setEmployerAge(rs.getInt("employer_age"));
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
		return employer; //직원 객체의 주소값을 리턴값으로한다
	}
	
	//직원 테이블 데이터 수정
	public void updateEmployer(Employer emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 테이블의 직원번호를 통해 직원이름과 직원나이 데이터를 수정하는 쿼리문 준비
			pstmt = conn.prepareStatement("update employer set employer_name=?, employer_age=? where employer_no=?");
			
			pstmt.setString(1, emp.getEmployerName()); //직원 이름
			pstmt.setInt(2, emp.getEmployerAge()); //직원 나이
			pstmt.setInt(3, emp.getEmployerNo()); //직원 번호
			
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
	
	//직원 데이터 삭제
	public void deleteEmployer(int employerNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 테이블에서 직원번호가 들어간 행을 전체 삭제
			pstmt = conn.prepareStatement("delete from employer where employer_no=?");
			
			pstmt.setInt(1, employerNo); //직원번호
			
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