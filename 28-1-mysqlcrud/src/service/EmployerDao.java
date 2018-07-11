//탁재은, 2018.07.09
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmployerDao {
	
	/*db연결 및 고용주 테이블에 데이터 상입
	--------------------------------------------
	employer_no | employer_name | employer_age
	--------------------------------------------
	 	1 |	 최윤석	 |	24
	--------------------------------------------
	*/
	//db의 고용주테이블에 데이터 저장 및 주소테이블의 employer_no컬럼에 고용주테이블의 employer_no값을 저장하기위해 고용주번호 검색
	public Employer insertEmployer(Employer emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//고용주 테이블에서 고용주 이름과 고용주 번호를 저장하기위한 쿼리문 준비
			pstmt = conn.prepareStatement("insert into employer (employer_name, employer_age) values (?, ?)");
			
			/*각 테이블의 기본키를 auto_increment로 주었기때문에
			고용주테이블에 먼저 데이터를 입력한 후 추가된 auto_increment를
			select문으로 받아 저장했습니다.*/
			//고용주 테이블의 고용주이름을 통해 고용주 번호를 검색하는 쿼리문 준비
			pstmt2 = conn.prepareStatement("select employer_no from employer where employer_name=?");
			
			pstmt.setString(1, emp.getEmployerName()); //고용주 이름
			pstmt.setInt(2, emp.getEmployerAge()); //고용주 나이
			
			pstmt2.setString(1, emp.getEmployerName()); //고용주 이름으로 검색
			
			pstmt.executeUpdate(); //쿼리문 실행
			System.out.println("고용주테이블저장");
			
			rs = pstmt2.executeQuery(); //쿼리문 실행
			System.out.println("고용주테이블select");
			
			if(rs.next()) {
				emp.setEmployerNo(rs.getInt("employer_no")); //넘버데이터 가져와서 변수에 저장
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
		return emp;
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
	//고용주리스트 작업
	public ArrayList<Employer> selectEmployerByPage(int currentPage, int pagePerRow, String word){
		ArrayList<Employer> employerList = new ArrayList<Employer>(); //ArrayList클래스를 통해 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			if(word.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//고용주 테이블에서 고용주번호와 고용주이름, 고용주나이를 검색하는 쿼리문 준비(조건 : 고용주번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select employer_no, employer_name, employer_age from employer order by employer_no limit ?, ?");
				
				pstmt.setInt(1, startPage);
				pstmt.setInt(2, pagePerRow);
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//고용주 테이블에서 고용주번호와 고용주이름, 고용주나이를 검색하는 쿼리문 준비(조건 : 고용주이름컬럼에서 지정한 문자가 들어가있는 열을 검색)
				pstmt = conn.prepareStatement("select employer_no, employer_name, employer_age from employer where employer_name like ? order by employer_no limit ?, ?");
				
				pstmt.setString(1, "%"+word+"%");
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
		return employerList; //고용주 객체의 주소값담은 배열객체의 주소값을 리턴
	}
	
	//고용주페이징 작업
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
			
			//고용주 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from employer");
			
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
	
	//고용주주소를 수정하기위해 리스트에 저장되어있는 데이터 찾기
	public Employer selectEmployer(int employerNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Employer employer = new Employer(); //Employer클래스를 통해 객체를 생성
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//고용주테이블의 고용주번호를 통해 고용주이름과 고용주나이를 검색하는 쿼리문 준비
			pstmt = conn.prepareStatement("select employer_name, employer_age from employer where employer_no=?");
			
			pstmt.setInt(1, employerNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				employer.setEmployerName(rs.getString("employer_name")); //ResultSet객체에서 꺼내온 데이터들을 고용주 객체의 주소값을 통해 데이터 저장 
				employer.setEmployerAge(rs.getInt("employer_age"));
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
		return employer; //고용주 객체의 주소값을 리턴값으로한다
	}
	
	//고용주 테이블 데이터 수정
	public void updateEmployer(Employer emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//고용주 테이블의 고용주번호를 통해 고용주이름과 고용주나이 데이터를 수정하는 쿼리문 준비
			pstmt = conn.prepareStatement("update employer set employer_name=?, employer_age=? where employer_no=?");
			
			pstmt.setString(1, emp.getEmployerName()); //고용주이름
			pstmt.setInt(2, emp.getEmployerAge()); //고용주나이
			pstmt.setInt(3, emp.getEmployerNo()); //고용주번호
			
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
	
	//고용주 데이터 삭제
	public void deleteEmployer(int employerNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//고용주 테이블에서 고용주번호가 들어간 행을 전체 삭제
			pstmt = conn.prepareStatement("delete from employer where employer_no=?");
			
			pstmt.setInt(1, employerNo);
			
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