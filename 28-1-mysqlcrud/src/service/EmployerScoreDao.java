//탁재은, 2018.07.11
package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmployerScoreDao {
	
	//db의 고용주점수 테이블에 고용주점수 저장
	public void insertScore(EmployerScore employerScore) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//고용주점수 테이블에 고용주번호와 점수를 저장하는 쿼리문 준비
			pstmt = conn.prepareStatement("insert into employer_score (employer_no, score) values (?, ?)");
			
			pstmt.setInt(1, employerScore.getEmployerNo()); //고용주 번호
			pstmt.setInt(2, employerScore.getScore()); //고용주 점수
			
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
	
	//점수 테이블과 고용주 테이블 조인해서 리스트화
	/*
	---------------------------------------------------------------
	employer_no | employer_name | employer_age	|	score
	---------------------------------------------------------------
	 	1 |	 최윤석	 |	24	|	90
	---------------------------------------------------------------
	 	2 |	 탁재은	 |	23	|	80
	---------------------------------------------------------------
	 	3 |	 김준영	 |	25	|	70
	---------------------------------------------------------------
	 	4 |	 김정연	 |	25	|	60
	---------------------------------------------------------------
	 	5 |	 김문수	 |	26	|	76
	---------------------------------------------------------------
	 	6 |	 이광재	 |	27	|	91
	---------------------------------------------------------------
	*/
	public ArrayList<EmployerAndScore> employerScoreJoin(int currentPage, int pagePerRow){
		ArrayList<EmployerAndScore> employerJoin = new ArrayList<EmployerAndScore>(); //join한 데이터들을 담은 객체의 주소값을 저장하기위한 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		try {
			Class.forName("com.mysql.jdbc.Driver"); //드라이버 로딩
				
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=utf-8", "dev28id", "dev28pw"); //db연결
			System.out.println("연결 확인");
			
			//점수테이블과 고용주테이블을 조인(join)해서 두 테이블의 컬럼값들을 리스트 처리할수있도록 쿼리문 준비(조건 : 지정한 숫자대로 테이블의 열을 보여준다)
			pstmt = conn.prepareStatement("select e.employer_no, e.employer_name, e.employer_age, es.score from employer_score es inner join employer e on es.employer_no=e.employer_no order by employer_no limit ?, ?");
			
			pstmt.setInt(1, startPage);
			pstmt.setInt(2, pagePerRow);
			
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {
				Employer employer = new Employer(); //고용주 테이블의 데이터를 저장하기위한 고용주 객체
				employer.setEmployerNo(rs.getInt("e.employer_no")); //고용주번호
				employer.setEmployerName(rs.getString("e.employer_name")); //고용주이름
				employer.setEmployerAge(rs.getInt("e.employer_age")); //고용주나이
				
				EmployerScore employerScore = new EmployerScore(); //점수 테이블의 데이터를 저장하기위한 점수 객체
				employerScore.setScore(rs.getInt("es.score")); //고용주점수
				
				EmployerAndScore employerAndScore = new EmployerAndScore(); //고용주 객체와 점수 객체의 주소값을 저장하는 조인객체
				employerAndScore.setEmployer(employer); //고용주 객체
				employerAndScore.setEmployerScore(employerScore); //점수 객체
				
				employerJoin.add(employerAndScore); //한번씩 반복될때마다 조인객체의 주소값을 인덱스에 저장
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
		return employerJoin; //조인객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}
	
	//고용주점수리스트 페이징 작업
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
			pstmt = conn.prepareStatement("select count(*) from employer_score");
			
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
	
	//고용주 테이블과 고용주 점수 테이블을 조인해서 평균점수를 넘은 고용주만 검색하는 메서드
	/*
	---------------------------------------------------------------
	employer_no | employer_name 	|	score
	---------------------------------------------------------------
	 	6 |	 이광재	 	|	91
	---------------------------------------------------------------
	 	1 |	 최윤석	|	90
	---------------------------------------------------------------
	 	2 |	 탁재은	|	80
	---------------------------------------------------------------
	*/
	public ArrayList<EmployerAndScore> selectEmployerListAboveAvg(int currentPage, int pagePerRow){
		ArrayList<EmployerAndScore> employerAvg = new ArrayList<EmployerAndScore>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=utf-8";
		String user = "dev28id";
		String password = "dev28pw";
		//고용주 테이블과 고용주 점수 테이블을 조인해서 no와 점수, 이름을 검색하면서 평균 점수보다 높은 점수를 가진 고용주만 출력하도록 조건을 주는 쿼리문 준비 (조건 : 점수가 가장 높은 고용주이 맨 위로 지정한 숫자대로 테이블의 열을 보여준다)
		String sql = "select e.employer_no, e.employer_name, es.score from employer e inner join employer_score es on e.employer_no=es.employer_no where score >= (select avg(score) from employer_score) order by score desc limit ?, ?";
		
		try {
			Class.forName(driver); //드라이버 로딩
				
			conn = DriverManager.getConnection(url, user, password); //db연결
			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement(sql); //쿼리문 준비
			
			pstmt.setInt(1, startPage);
			pstmt.setInt(2, pagePerRow);
			
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {
				Employer employer = new Employer(); //고용주 테이블의 데이터를 저장하기위한 고용주 객체
				employer.setEmployerNo(rs.getInt("e.employer_no")); //고용주번호
				employer.setEmployerName(rs.getString("e.employer_name")); //고용주이름
				
				EmployerScore employerScore = new EmployerScore(); //점수 테이블의 데이터를 저장하기위한 점수 객체
				employerScore.setScore(rs.getInt("es.score")); //고용주점수
				
				EmployerAndScore employerAndScore = new EmployerAndScore(); //고용주 객체와 점수 객체의 주소값을 저장하는 조인객체
				employerAndScore.setEmployer(employer); //고용주 객체
				employerAndScore.setEmployerScore(employerScore); //점수 객체
				
				employerAvg.add(employerAndScore); //한번씩 반복될때마다 조인객체의 주소값을 인덱스에 저장
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
		return employerAvg; //조인객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}
	
	//평균점수를 구하는 메서드
	public int selectScoreAvg() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int avg = 0; //평균점수를 저장할 변수
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=utf-8";
		String user = "dev28id";
		String password = "dev28pw";
		//고용주 점수테이블에서 집합함수를 사용해서 평균점수를 검색
		String sql = "select avg(score) from employer_score order by score desc";
		
		try {
			Class.forName(driver); //드라이버 로딩
				
			conn = DriverManager.getConnection(url, user, password); //db연결
			System.out.println("연결 확인");
			
			pstmt = conn.prepareStatement(sql); //쿼리문 준비
			
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {
				avg = rs.getInt("avg(score)");
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
		return avg; //검색한 평균점수의 값을 담은 변수를 리턴
	}	
}
