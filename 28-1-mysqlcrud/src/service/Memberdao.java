//2018-06-26 28기 송원민 모델1 insert 작업
package service; // 패키지 앞의 이름은 소문자를 적어주어야한다(대문자는 왠만하면 사용 안하는것이 좋다.)

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Memberdao { // 클래스명 맨앞 문자는 무조건 대문자여야합니다.

	public void InsertMember(Member m) { 
		/*void를 쓴 이유는 멤버변수를 사용하지 않고 메소드 안의 지역변수를 사용해주었기 때문에 */
			
			Connection conn = null;
			PreparedStatement pstmt = null;
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			// Class 클래스의 forName()함수를 이용하여 해당 클래스 메모리를 로드한다("동적로딩"
			
			
			String jdbcDriver = "jdbc:mysql://localhost:3306/dev28db?useUnicode=true&characterEncoding=euckr";
			String dbUser = "dev28id";
			String dbPass = "dev28pw";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			pstmt = conn.prepareStatement("insert into member (member_name, member_age) values(?,?)");
			System.out.println(conn + "<-- Conn��");
			pstmt.setString(1, m.getMember_name()); // ù��° ?���� �����Ѵ�.
			pstmt.setInt(2, m.getMember_age()); 
			
			pstmt.executeUpdate();
		
		} catch (SQLException e) {
			e.printStackTrace(); // 
			
		
		} catch (ClassNotFoundException e) {
			e.printStackTrace(); // 
		 /* try문안에 Class 클래스에서 forName 메소드를 호출할 때 오류가 발생할 경우 catch문으로 넘어와
			Class 클래스에서 forName 메소드를 호출할 때  발생하는 예외인 ClassNotFoundException 객체 안에
			단계별로 발생한 에러를 출력한다.*/
		
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
		/* finally문이 무조건 필요한 것은 아니다. finally가 사용되면 안의 내용은 무조건 실행 시켜야 하며 try 다음 catch 문장에 return; 이 있다고 해도 finally로 넘어온다.*/
	}

}
