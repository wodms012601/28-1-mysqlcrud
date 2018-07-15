//탁재은, 2018.07.12
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmployerScoreDao {
	
	//db의 직원점수 테이블에 직원점수 저장
	public void insertScore(EmployerScore employerScore) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원점수 테이블에 직원번호와 점수를 저장하는 쿼리문 준비
			pstmt = conn.prepareStatement("insert into employer_score (employer_no, score) values (?, ?)");
			
			pstmt.setInt(1, employerScore.getEmployerNo()); //직원 번호
			pstmt.setInt(2, employerScore.getScore()); //직원 점수
			
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
	
	//직원점수 테이블과 직원 테이블 조인해서 리스트화
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
	public ArrayList<EmployerAndScore> employerScoreJoin(int currentPage, int pagePerRow, String scoreKeyword){
		ArrayList<EmployerAndScore> employerJoin = new ArrayList<EmployerAndScore>(); //join한 데이터들을 담은 객체의 주소값을 저장하기위한 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			if(scoreKeyword.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//직원점수테이블과 직원테이블을 조인(join)해서 두 테이블의 컬럼값들을 리스트 처리할수있도록 쿼리문 준비(조건 : 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select e.employer_no, e.employer_name, e.employer_age, es.score from employer_score es inner join employer e on es.employer_no=e.employer_no order by employer_no desc limit ?, ?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//직원점수테이블과 직원테이블을 조인(join)해서 검색한결과의 값들을 리스트 처리할수있도록 쿼리문 준비(조건 : 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select e.employer_no, e.employer_name, e.employer_age, es.score from employer_score es inner join employer e on es.employer_no=e.employer_no where score like ? order by employer_no desc limit ?, ?");
				
				pstmt.setString(1, "%"+scoreKeyword+"%");
				pstmt.setInt(2, startPage);
				pstmt.setInt(3, pagePerRow);
			}
			
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {
				Employer employer = new Employer(); //직원 테이블의 데이터를 저장하기위한 직원 객체
				employer.setEmployerNo(rs.getInt("e.employer_no")); //직원 번호
				employer.setEmployerName(rs.getString("e.employer_name")); //직원 이름
				employer.setEmployerAge(rs.getInt("e.employer_age")); //직원 나이
				
				EmployerScore employerScore = new EmployerScore(); //직원점수 테이블의 데이터를 저장하기위한 직원점수 객체
				employerScore.setScore(rs.getInt("es.score")); //직원점수
				
				EmployerAndScore employerAndScore = new EmployerAndScore(); //직원 객체와 직원점수 객체의 주소값을 저장하는 조인객체
				employerAndScore.setEmployer(employer); //직원 객체
				employerAndScore.setEmployerScore(employerScore); //직원점수 객체
				
				employerJoin.add(employerAndScore); //한번씩 반복될때마다 조인객체의 주소값을 인덱스에 저장
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
		return employerJoin; //조인객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}
	
	//직원점수리스트 페이징 작업
	public int paging(int pagePerRow, String scoreKeyword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from employer_score inner join employer on employer_score.employer_no=employer.employer_no where score like ?");
			
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
	
	//직원점수리스트 페이징 작업
	public int paging(int pagePerRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from employer_score where score >= (select avg(score) from employer_score)");
			
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
	
	//직원 테이블과 직원 점수 테이블을 조인해서 평균점수를 넘은 직원만 검색하는 메서드
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
		
		//직원 테이블과 직원 점수 테이블을 조인해서 no와 점수, 이름을 검색하면서 평균 점수보다 높은 점수를 가진 직원만 출력하도록 조건을 주는 쿼리문 준비 (조건 : 점수가 가장 높은 직원이 맨 위로, 지정한 숫자대로 테이블의 열을 보여준다)
		String sql = "select e.employer_no, e.employer_name, e.employer_age, es.score from employer e inner join employer_score es on e.employer_no=es.employer_no where score >= (select avg(score) from employer_score) order by score desc limit ?, ?";
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement(sql); //쿼리문 준비
			
			pstmt.setInt(1, startPage); //시작지점
			pstmt.setInt(2, pagePerRow); //열의 갯수
			
			rs = pstmt.executeQuery(); //쿼리문 실행
			
			while(rs.next()) {
				Employer employer = new Employer(); //직원 테이블의 데이터를 저장하기위한 직원 객체
				employer.setEmployerNo(rs.getInt("e.employer_no")); //직원번호
				employer.setEmployerName(rs.getString("e.employer_name")); //직원이름
				employer.setEmployerAge(rs.getInt("e.employer_age")); //직원나이
				
				EmployerScore employerScore = new EmployerScore(); //직원점수 테이블의 데이터를 저장하기위한 직원점수 객체
				employerScore.setScore(rs.getInt("es.score")); //직원점수
				
				EmployerAndScore employerAndScore = new EmployerAndScore(); //직원 객체와 직원점수 객체의 주소값을 저장하는 조인객체
				employerAndScore.setEmployer(employer); //직원 객체
				employerAndScore.setEmployerScore(employerScore); //직원점수 객체
				
				employerAvg.add(employerAndScore); //한번씩 반복될때마다 조인객체의 주소값을 인덱스에 저장
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
		return employerAvg; //조인객체의 주소값들이 저장된 배열객체의 주소값을 리턴
	}
	
	//직원점수 테이블의 평균점수를 구하는 메서드
	public int selectScoreAvg() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int avg = 0; //평균점수를 저장할 변수
		
		//직원점수 테이블에서 집합함수를 사용해서 평균점수를 검색
		String sql = "select avg(score) from employer_score order by score desc";
		
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
	employer_score_no | employer_no | score
	--------------------------------------------
	 	1 |	 1	 |	90
	--------------------------------------------
	*/
	//직원점수 테이블에서 한명의 직원점수 검색
	public EmployerScore selectEmployerScore(int employerNo) {
		EmployerScore employerScore = new EmployerScore(); //EmployerScore클래스를 통해 객체를 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원점수 테이블에서 직원번호를 통해 점수번호, 직원번호, 직원점수 데이터를 찾는 쿼리문 준비
			pstmt = conn.prepareStatement("select employer_score_no, employer_no, score from employer_score where employer_no=?");
			
			pstmt.setInt(1, employerNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				employerScore.setEmployerScoreNo(rs.getInt("employer_score_no")); //ResultSet객체에서 꺼내온 데이터들을  직원점수 객체의 주소값을 통해 데이터 저장 
				employerScore.setEmployerNo(rs.getInt("employer_no"));
				employerScore.setScore(rs.getInt("score"));
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
		return employerScore; //직원점수 객체의 주소값을 리턴값으로한다
	}
	
	//직원점수 테이블 데이터 수정
	public void updateEmployerScore(EmployerScore empScore) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원점수 테이블의 직원번호를 통해 직원점수를 수정하는 쿼리문 준비
			pstmt = conn.prepareStatement("update employer_score set score=? where employer_no=?");
		
			pstmt.setInt(1, empScore.getScore()); //직원점수
			pstmt.setInt(2, empScore.getEmployerNo()); //직원번호
			
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
	
	//직원점수 데이터 삭제
	public void deleteEmployerScore(int employerNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 테이블에서 직원번호가 들어간 행을 전체 삭제
			pstmt = conn.prepareStatement("delete from employer_score where employer_no=?");
			
			pstmt.setInt(1, employerNo);
			
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
