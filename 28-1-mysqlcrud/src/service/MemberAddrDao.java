//07.10 송원민 Member_addr 리스트 처리
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberAddrDao {
	// member_addr insert 작업 메서드
	public void insertaddrList(MemberAddr addr) { // 데이터베이스안에 입력값을 넣기 위해 MemberAddr 데이터 타입을 사용하는 메서드
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("insert into member_addr(member_no, member_addr_content) values(?,?)");
			pstmt.setInt(1, addr.getMember_no());
			pstmt.setString(2, addr.getMember_addr_content());
			
			pstmt.executeUpdate();
			
		} catch(SQLException e) {
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
	
	// member_addr select 작업 메서드
		public ArrayList<MemberAddr> addrList(int no) { //memberAddList.jsp 에서 int no 값을 받아 회원번호에 따른 리스트를 출력하기 위한 메서드
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ArrayList<MemberAddr> list = new ArrayList<>();
			// 회원 한명이 여러번의 값을 입력할 수 있기 때문에 ArrayList 배열을 사용하였다.
			
			try {
				Database database = new Database();
				conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
				
				pstmt = conn.prepareStatement("select member_addr_no, member_no, member_addr_content from member_addr where member_no=?");
				pstmt.setInt(1, no);
				
				rs = pstmt.executeQuery();
				MemberAddr m1 = null;
				
				while (rs.next()) {
					m1 = new MemberAddr();
					m1.setMember_addr_no(Integer.parseInt(rs.getString("member_addr_no")));
					m1.setMember_no(Integer.parseInt(rs.getString("member_no")));
					m1.setMember_addr_content(rs.getString("member_addr_content"));
					
					list.add(m1);
				}
			} catch(SQLException e) {
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
		
		// 부모테이블 member, 자식테이블 member_addr에 join을 사용하여 회원주소번호, 회원이름, 주소를 조회하는 메서드 
		public ArrayList<MemberAddr> allSelectMember(int currentpage, int pagePerRow, String addrKeyword) { 
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ArrayList<MemberAddr> list1 = new ArrayList<>();
		
			int startPage = (currentpage -1) * pagePerRow;
			
			try {
				Database database = new Database();
				conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
				
				if(addrKeyword.equals("")) { //검색이 없을 경우 그대로 리스트 처리
					//회원 테이블에서회원번호와회원이름, 회원나이를 검색하는 쿼리문 준비(조건 : 학생번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
					pstmt = conn.prepareStatement("select ma.member_addr_no, m.member_name, ma.member_addr_content from member_addr ma inner join member m on ma.member_no = m.member_no \r\n" + 
							"order by member_addr_no desc limit ?,?");
					
					pstmt.setInt(1, startPage); //시작지점
					pstmt.setInt(2, pagePerRow); //열의 갯수
					
				} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
					//회원 테이블에서 회원번호와 회원이름, 회원나이를 검색하는 쿼리문 준비(조건 : 학생이름컬럼에서 지정한 문자가 들어가있는 열을 검색)
					pstmt = conn.prepareStatement("select ma.member_addr_no, m.member_name, ma.member_addr_content from member_addr ma inner join member m on ma.member_no = m.member_no \r\n" + 
							"where member_addr_content like ? order by member_addr_no desc limit ?,?");
					
					pstmt.setString(1, "%"+addrKeyword+"%");
					pstmt.setInt(2, startPage);
					pstmt.setInt(3, pagePerRow);
				}
				
				// 회원번호가 어느것이냐에 따라 회원주소번호,내용을 출력하는 쿼리문
				
				rs = pstmt.executeQuery();
				MemberAddr m1 = null;
				Member m2 = null;
				
				while (rs.next()) {
					m1 = new MemberAddr();
					m2 = new Member();
					
					m1.setMember_addr_no(Integer.parseInt(rs.getString("ma.member_addr_no")));
					m1.setMember_addr_content(rs.getString("ma.member_addr_content"));
					m2.setMember_name(rs.getString("m.member_name"));
					
					m1.setMemberaddr(m1);
					m1.setMember(m2);
					
					list1.add(m1);
				}
			} catch(SQLException e) {
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
			return list1;
		}	
		
		public int paging(int pagePerRow, String addrKeyword) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			int totalRow = 0;
			int lastPage = 0;
			
			try {
				Database database = new Database();
				conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
				
				pstmt = conn.prepareStatement("select count(*) from member_addr where member_addr_content like ?");
				pstmt.setString(1, "%"+addrKeyword+"%");
				
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
