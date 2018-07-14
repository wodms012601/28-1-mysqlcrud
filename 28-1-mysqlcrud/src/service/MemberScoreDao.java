package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberScoreDao {
	//점수입력하는 화면 a는 회원번호, b는 점수
	public void insertScore(int a, int b) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("insert into member_score (member_no, score) values(?,?)");
			pstmt.setInt(1, a);
			pstmt.setInt(2, b);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				} 
				catch(SQLException e) {
					e.printStackTrace();
				}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
		}
		
	}
	
	
	public int selectScoreAvg() { // 평균을 구하는 메서드
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int a = 0;
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("(select avg(score) from member_score)");
			
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				a = rs.getInt("avg(score)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
		}
		return a;
	}
	
	// 전체점수리스트 메서드
	public ArrayList<MemberAndScore> memberScoreJoin(int currentpage, int pagePerRow, String scoreKeyword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberAndScore> list2 = new ArrayList<>();
		System.out.println(scoreKeyword + "--요거");
		
		int startPage = (currentpage -1) * pagePerRow;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			if(scoreKeyword.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//회원 테이블에서회원번호와회원이름, 회원나이를 검색하는 쿼리문 준비(조건 : 학생번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select m.member_no, m.member_name, m.member_age, ma.score from member m inner join member_score ma on m.member_no = ma.member_no order by member_no desc limit ?,?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//회원 테이블에서 회원번호와 회원이름, 회원나이를 검색하는 쿼리문 준비(조건 : 학생이름컬럼에서 지정한 문자가 들어가있는 열을 검색)
				pstmt = conn.prepareStatement("select m.member_no, m.member_name, m.member_age, ma.score from member m inner join member_score ma on m.member_no = ma.member_no where score like ? order by member_no desc limit ?,?");
				
				pstmt.setString(1, "%"+scoreKeyword+"%");
				pstmt.setInt(2, startPage);
				pstmt.setInt(3, pagePerRow);
			}
			
			rs = pstmt.executeQuery();
			
			
			MemberAndScore m = null;
			Member m1 = null;
			MemberScore m2 = null;
			while(rs.next()) {
				m = new MemberAndScore();
				m1 = new Member();
				m2 = new MemberScore();
				
				m1.setMember_no(rs.getInt("m.member_no"));
				m1.setMember_name(rs.getString("m.member_name"));
				m1.setMember_age(rs.getInt("m.member_age"));
				m2.setScore(Integer.parseInt(rs.getString("ma.score")));
				m.setMember(m1);
				m.setMemberScore(m2);
				
				list2.add(m);
				System.out.println(list2 + "--요거");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
		}
		return list2;
	}
	
	// 평균 이상인 학생들의 정보를 조회하는 메서드 선언 
	public ArrayList<MemberAndScore> selectMemberListAboveAvg(int currentPage, int pagePerRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberAndScore> list = new ArrayList<>();
		
		int startPage = (currentPage - 1) * pagePerRow; //처음 보는 글
		
		String sql = "select m.member_no, m.member_name, m.member_age, ms.score from member_score ms inner join member m on ms.member_no "
				+ "= m.member_no where ms.score >= (select avg(score) from member_score) order by score desc limit ?, ?";
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, startPage); //시작지점
			pstmt.setInt(2, pagePerRow); //열의 갯수
			
			rs = pstmt.executeQuery();
			
			MemberAndScore m = null;
			Member m1 = null;
			MemberScore m2 = null;
			while(rs.next()) {
				m = new MemberAndScore();
				m1 = new Member();
				m2 = new MemberScore();
				
				m1.setMember_no(Integer.parseInt(rs.getString("m.member_no")));
				m1.setMember_name(rs.getString("m.member_name"));
				m1.setMember_age((rs.getInt("m.member_age")));
				m2.setScore(Integer.parseInt(rs.getString("ms.score")));
				m.setMember(m1);
				m.setMemberScore(m2);
				
				list.add(m);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
		}
		return list;
	}
	
	//회원한명점수를 수정하는 메서드
	public void updateMemberScore(int score, int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("update member_score set score=? where member_no=?");
			pstmt.setInt(1, score);
			pstmt.setInt(2, no);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
		} 
	}
	
	//회원한명의 점수를 조회하는 메서드
	public MemberScore selectMemberScore(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberScore ms = null;

		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("select member_score_no, member_no, score from member_score where member_no=?");
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				ms = new MemberScore();
				ms.setMemberScoreNo(rs.getInt("member_score_no"));
				ms.setMemberNo(rs.getInt("member_no"));
				ms.setScore(rs.getInt("score"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				}
				catch(SQLException e) {
					e.printStackTrace();
				}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
		} 
		return ms;
	}
	
	//임의의 회원점수를 제거하는 메서드
	public void deleteScoreMember(String id) { 
		/*void를 쓴 이유는 멤버변수를 사용하지 않고 메소드 안의 지역변수를 사용해주었기 때문에 */
			
			Connection conn = null;
			PreparedStatement pstmt = null;
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("delete from member_score where member_no=?");
			
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace(); 
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				} 
				catch(SQLException e) {
					e.printStackTrace();
				}
			}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
		  
		}
	
	//점수보기 페이징처리
	public int paging(int pagePerRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0; //모든 행의 갯수를 담을 변수
		int lastPage = 0; //마지막 페이지를 담을 변수
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			//학생 테이블의 전체행의 값을 구하는 쿼리문 준비
			pstmt = conn.prepareStatement("select count(*) from member_score");
			
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
	
	//검색하는 점수 페이징처리
	public int paging(int pagePerRow, String scoreKeyword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0;
		int lastPage = 0;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("select count(*) from member_score where score like ?");
			pstmt.setString(1, "%"+scoreKeyword+"%");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalRow = rs.getInt("count(*)");
			}
			
			if(totalRow % pagePerRow == 0) {
				lastPage = totalRow / pagePerRow;
			} else {
				lastPage = (totalRow / pagePerRow) + 1;
			}
		
		} catch (SQLException e) {
				e.printStackTrace();
		} finally {
			if (pstmt != null)
				try { 
					pstmt.close(); 
				} 
				catch(SQLException e) {
					e.printStackTrace();
				}
			if (conn != null) 
				try {
					conn.close(); 
				} catch(SQLException e) {
					e.printStackTrace();	
				}
		}
		return lastPage;
	}
}
