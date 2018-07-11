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
			MemberScoreDao dao3 = new MemberScoreDao();
			
			ArrayList<MemberAndScore> result3= dao3.overSelectMemberList();
			
			for(int i=0; i<result3.size(); i++) {
		%>
				<table border="1">
					<tr>
						<td>회원번호</td>
						<td>회원이름</td>
						<td>점수</td>
					</tr>
					<tr>
						<td><%=result3.get(i).getMember().getMember_no() %></td>
						<td><%=result3.get(i).getMember().getMember_name() %></td>
						<td><%=result3.get(i).getMemberScore().getScore() %></td>
					</tr>
				</table>
		<%		
			}
		%>
	</body>
</html>