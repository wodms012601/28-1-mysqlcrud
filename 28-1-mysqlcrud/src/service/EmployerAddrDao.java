//탁재은, 2018.07.12
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmployerAddrDao {
	
	//db의 직원주소테이블에 데이터 저장
	public void insertEmployerAddr(EmployerAddr addr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 주소 테이블에서 직원번호와 직원주소를 저장하는 쿼리문 준비
			pstmt = conn.prepareStatement("insert into employer_addr (employer_no, employer_addr_content) values (?, ?)");
			
			pstmt.setInt(1, addr.getEmployerNo());
			pstmt.setString(2, addr.getEmployerAddrContent());
			
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
	employer_addr_no | employer_no | employer_addr_content
	--------------------------------------------
	 	1 |	 1	 |	전주시
	--------------------------------------------
	 	2 |	 2	 |	서울
	--------------------------------------------
	 	3 |	 3	 |	부산
	--------------------------------------------
	 	4 |	 4	 |	대구
	--------------------------------------------
	 	5 |	 5	 |	천안
	--------------------------------------------
	 	6 |	 6	 |	구미
	--------------------------------------------
	*/
	//직원주소리스트 작업
	public ArrayList<EmployerAddr> selectEmployerAddrList(int currentPage, int pagePerRow, String addrKeyword) {
		ArrayList<EmployerAddr> employerAddrList = new ArrayList<EmployerAddr>(); //직원 주소객체의 주소값을 저장할 배열객체 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글

		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			if(addrKeyword.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//직원주소 테이블에서 직원번호와 직원주소번호, 직원주소를 검색하는 쿼리문 준비(조건 : 직원번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select employer_addr_no, employer_no, employer_addr_content from employer_addr order by employer_addr_no desc limit ?, ?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//직원 테이블에서 직원번호와 직원주소번호, 직원주소를 검색하는 쿼리문 준비(조건 : 직원이름컬럼에서 지정한 문자가 들어가있는 열을 검색)
				pstmt = conn.prepareStatement("select employer_addr_no, employer_no, employer_addr_content from employer_addr where employer_addr_content like ? order by employer_addr_no desc limit ?, ?");
				
				pstmt.setString(1, "%"+addrKeyword+"%");
				pstmt.setInt(2, startPage);
				pstmt.setInt(3, pagePerRow);
			}

			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			while(rs.next()) {
				EmployerAddr addr = new EmployerAddr(); //ResultSet객체에서 꺼내온 데이터들을  직원주소 객체의 주소값을 통해 데이터 저장 
				addr.setEmployerAddrNo(rs.getInt("employer_addr_no")); //직원 주소번호
				addr.setEmployerNo(rs.getInt("employer_no")); //직원 번호
				addr.setEmployerAddrContent(rs.getString("employer_addr_content")); //직원 주소
				
				employerAddrList.add(addr); //한번씩 반복될때마다 직원 주소객체의 주소값을 인덱스에 저장
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
		return employerAddrList; //직원주소 객체의 주소값담은 배열객체의 주소값을 리턴
	}
	
	/*
	--------------------------------------------
	employer_addr_no | employer_no | employer_addr_content
	--------------------------------------------
	 	1 |	 1	 |	전주시
	--------------------------------------------
	*/
	//직원 주소테이블에서 한명의 직원 주소검색
	public EmployerAddr selectEmployerAddr(int employerNo) {
		EmployerAddr employerAddr = new EmployerAddr(); //EmployerAddr클래스를 통해 객체를 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원주소 테이블에서 직원번호를 통해 직원주소번호, 직원번호, 직원주소 데이터를 찾는 쿼리문 준비
			pstmt = conn.prepareStatement("select employer_addr_no, employer_no, employer_addr_content from employer_addr where employer_no=?");
			
			pstmt.setInt(1, employerNo);
			
			rs = pstmt.executeQuery(); //쿼리문 실행 및 ResultSet객체 생성
			
			if(rs.next()) {
				employerAddr.setEmployerAddrNo(rs.getInt("employer_addr_no")); //ResultSet객체에서 꺼내온 데이터들을 직원주소 객체의 주소값을 통해 데이터 저장 
				employerAddr.setEmployerNo(rs.getInt("employer_no"));
				employerAddr.setEmployerAddrContent(rs.getString("employer_addr_content"));
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
		return employerAddr; //직원주소 객체의 주소값을 리턴값으로한다
	}
	
	//직원 리스트 페이징 작업
	public int paging(int pagePerRow, String addrKeyword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from employer_addr where employer_addr_content like ? ");
			
			pstmt.setString(1, "%"+addrKeyword+"%");
			
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
	
	//직원주소 테이블 데이터 수정
	public void updateEmployerAddr(EmployerAddr empAddr) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 주소테이블의 직원번호를 통해 직원주소 데이터를 수정하는 쿼리문 준비
			pstmt = conn.prepareStatement("update employer_addr set employer_addr_content=? where employer_no=?");
			
			pstmt.setString(1, empAddr.getEmployerAddrContent()); //직원 주소
			pstmt.setInt(2, empAddr.getEmployerNo()); //직원 번호
			
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
		
	//직원주소 데이터 삭제
	public void deleteEmployerAddr(int employerNo) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//직원 주소 테이블에서 직원번호가 들어간 행을 전체 삭제
			pstmt = conn.prepareStatement("delete from employer_addr where employer_no=?");
			
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
