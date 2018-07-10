//탁재은, 2018.07.09
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmployerDao {
	
	//db의 고용주 테이블에 고용주데이터를 저장
	public void insertEmployer(Employer emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//고용주테이블에 고용주이름과 고용주나이를 저장하는 쿼리문 준비
			pstmt = conn.prepareStatement("insert into employer (employer_name, employer_age) values (?, ?)");
			
			pstmt.setString(1, emp.getEmployerName()); //고용주이름
			pstmt.setInt(2, emp.getEmployerAge()); //고용주나이
			
			pstmt.executeUpdate(); //쿼리문 실행
			System.out.println("고용주테이블저장");
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally{
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
}
