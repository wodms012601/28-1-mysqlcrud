//2018-06-26 28기 송원민 모델1 insert 작업
package service; // 패키지 앞의 이름은 소문자를 적어주어야한다(대문자는 왠만하면 사용 안하는것이 좋다.)

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberDao { // 클래스명 맨앞 문자는 무조건 대문자여야합니다.

	public void insertMember(Member m) { 
		/*void를 쓴 이유는 멤버변수를 사용하지 않고 메소드 안의 지역변수를 사용해주었기 때문에 */
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("insert into member (member_name, member_age) values(?,?)");
			
			System.out.println(conn + "<-- Conn��");
			pstmt.setString(1, m.getMember_name());
			pstmt.setInt(2, m.getMember_age()); 
			
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
		/* finally문이 무조건 필요한 것은 아니다. finally가 사용되면 안의 내용은 무조건 실행 시켜야 하며 try 다음 catch 문장에 return; 이 있다고 해도 finally로 넘어온다.*/
	
	// 회원정보삭제
	public void deleteMember(String id) { 
		/*void를 쓴 이유는 멤버변수를 사용하지 않고 메소드 안의 지역변수를 사용해주었기 때문에 */
			
			Connection conn = null;
			PreparedStatement pstmt = null;
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("delete from member where member_no=?");
			
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace(); // 
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
	//회원이름, 나이를 수정하기위해 리스트에 저장되어있는 데이터 찾기
	public Member selectMember(String no) { 
		/*void를 쓴 이유는 멤버변수를 사용하지 않고 메소드 안의 지역변수를 사용해주었기 때문에 */
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Member m = null;
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("select member_no, member_name, member_age from member where member_no=?");
			pstmt.setString(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				m = new Member();
				m.setMember_name(rs.getString("member_name"));
				m.setMember_age(Integer.parseInt(rs.getString("member_age")));
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
			}
		    if (conn != null) 
		    	try {
		    		conn.close(); 
		    	} catch(SQLException e) {
		    		e.printStackTrace();	
		    	}
			return m;
		}
	
	public void updateMember(String name, String age, String no) { 
		/*void를 쓴 이유는 멤버변수를 사용하지 않고 메소드 안의 지역변수를 사용해주었기 때문에 */
			Connection conn = null;
			PreparedStatement pstmt = null;
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("update member set member_name=? , member_age=? where member_no=?");
			pstmt.setString(1, name);
			pstmt.setString(2, age);
			pstmt.setString(3, no);
			
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
	
	public ArrayList<Member> selectMemberByPage(int currentpage, int pagePerRow, String nameKeyword) {
		
		ArrayList<Member> list = new ArrayList<Member>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startPage = (currentpage -1) * pagePerRow;
	try {
			
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			if(nameKeyword.equals("")) { //검색이 없을 경우 그대로 리스트 처리
				//회원 테이블에서회원번호와회원이름, 회원나이를 검색하는 쿼리문 준비(조건 : 학생번호를 기점으로 오름차순, 지정한 숫자대로 테이블의 열을 보여준다)
				pstmt = conn.prepareStatement("select member_no, member_name, member_age from member order by member_no desc limit ?, ?");
				
				pstmt.setInt(1, startPage); //시작지점
				pstmt.setInt(2, pagePerRow); //열의 갯수
				
			} else { //검색이 있을경우 검색한 문자가 포함된 결과를 리스트로 처리
				//회원 테이블에서 회원번호와 회원이름, 회원나이를 검색하는 쿼리문 준비(조건 : 학생이름컬럼에서 지정한 문자가 들어가있는 열을 검색)
				pstmt = conn.prepareStatement("select member_no, member_name, member_age from member where member_name like ? order by member_no desc limit ?, ?");
				
				pstmt.setString(1, "%"+nameKeyword+"%");
				pstmt.setInt(2, startPage);
				pstmt.setInt(3, pagePerRow);
			}
			
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				Member m = new Member();
				m.setMember_no(rs.getInt("member_no"));
				m.setMember_name(rs.getString("member_name"));
				m.setMember_age(rs.getInt("member_age"));
				list.add(m);
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
		System.out.println(list+"33");
		return list;
	}
	
	//memberList.jsp 리스트화면 페이징처리
	public int paging(int pagePerRow, String nameKeyword) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int totalRow = 0;
		int lastPage = 0;
		
		try {
			Database database = new Database();
			conn = database.databaseConnect(); //드라이버 로딩 및 db연결하는 메서드 호출하고 Connection객체의 주소값을 리턴받는다.
			
			pstmt = conn.prepareStatement("select count(*) from member where member_name like ?");
			pstmt.setString(1, "%"+nameKeyword+"%");
			
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
