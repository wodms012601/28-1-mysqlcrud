<!-- 07.10 송원민 list작업 -->
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
			request.setCharacterEncoding("euc-kr");
		
			int no = Integer.parseInt(request.getParameter("no"));
			
			MemberAddrDao addr = new MemberAddrDao();
			
			ArrayList<MemberAddr> result = addr.addrList(no);
			for(int i=0; i<result.size(); i++) {
		%>
		
		<table border="1">
			<tr>
				<td>번호</td>
				<td>회원번호</td>
				<td>내용</td>
			</tr>
			<tr>
				<td><%=result.get(i).getMember_addr_no() %></td>
				<td><%=result.get(i).getMember_no() %></td>
				<td><%=result.get(i).getMember_addr_content() %></td>
			</tr>
		</table>		
		
				
		<%		
			}
		%>
	</body>
</html>