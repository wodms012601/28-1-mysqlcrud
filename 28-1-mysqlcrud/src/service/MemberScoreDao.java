package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberScoreDao {
	//스코어 처리 메서드 매개변수 a는 회원번호, b는 점수
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
	
	public int selectScoreAvg() { // 평균을 구하는 메서드도 만들어 줘야함
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
	
	// 한화면당 평균90점이상의 회원점수정보를 몇개 꺼내올건지에 대한 메서드  선언(페이징처리)
	public ArrayList<MemberAndScore> selectMemberListAvg(int currentPage, int perPerRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberAndScore> list = new ArrayList<>();
		int startPage = (currentPage -1) * perPerRow;
		
		String sql = "select member_score_no, member_no, score from member_score where score >= (select avg(score) from member_score) order by member_no limit ?,?";
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startPage);
			pstmt.setInt(2, perPerRow);
			
			rs = pstmt.executeQuery();
			
			MemberAndScore m = null;
			Member m1 = null;
			MemberScore m2 = null;
			while(rs.next()) {
				m = new MemberAndScore();
				m1 = new Member();
				m2 = new MemberScore();
				
				
				m2.setMemberScoreNo(Integer.parseInt(rs.getString("member_score_no")));
				m1.setMember_no(Integer.parseInt(rs.getString("member_no")));
				m2.setScore(Integer.parseInt(rs.getString("score")));
				
				
				m.setMemberScore(m2);
				m.setMember(m1);
				
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
	
	// 전체점수리스트 메서드
	public ArrayList<MemberAndScore> AllSelectMemberAndScore() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberAndScore> list2 = new ArrayList<>();
		
		String sql = "select m.member_no, m.member_name, ms.score from member_score ms inner join member m on ms.member_no = m.member_no";
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement(sql);
			
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
				m2.setScore(Integer.parseInt(rs.getString("ms.score")));
				m.setMember(m1);
				m.setMemberScore(m2);
				
				list2.add(m);
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
	
	// 평균 90이상인 학생들의 정보를 조회하는 메서드 선언 
	public ArrayList<MemberAndScore> overSelectMemberList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<MemberAndScore> list = new ArrayList<>();
		
		String sql = "select m.member_no, m.member_name, ms.score from member_score ms inner join member m on ms.member_no "
				+ "= m.member_no where ms.score >= (select avg(score) from member_score) order by ms.score ASC";
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement(sql);
			
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
	
	public void updateScore(int score, int no) {
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
	
	public MemberScore selectUpdateScore(int no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberScore m = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("select score from member_score where member_no=?");
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				m = new MemberScore();
				m.setScore(Integer.parseInt(rs.getString("score")));;
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
		return m;
	}
	
	public MemberScore selectScore(int no) {
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
				ms.setMemberScoreNo(Integer.parseInt(rs.getString("member_score_no")));
				ms.setMemberNo(Integer.parseInt(rs.getString("member_no")));
				ms.setScore(Integer.parseInt(rs.getString("score")));
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
	
	public int paging(int pagePerRow) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0;
		int lastPage = 0;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("select count(*) from member_score where score >= (select avg(score) from member_score);");
			
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
