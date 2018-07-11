<!-- 전체 회원 리스트  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			
			MemberAddrDao dao4 = new MemberAddrDao();
			ArrayList<MemberAddr> result = dao4.allSelectMember();
			
			for(int i=0; i<result.size(); i++) {
		%>
		
				<table border="1">
					<tr>
						<td>회원주소번호</td>
						<td>회원이름</td>
						<td>주소내용</td>
					</tr>
					<tr>
						<td><%=result.get(i).getMemberaddr().getMember_addr_no() %></td>
						<td><%=result.get(i).getMember().getMember_name() %></td>
						<td><%=result.get(i).getMemberaddr().getMember_addr_content() %></td>
					</tr>
				</table>				
		<%		
			}
		%>
		
			<a href="<%= request.getContextPath() %>/index.jsp">돌아가기</a>
	</body>
</html>