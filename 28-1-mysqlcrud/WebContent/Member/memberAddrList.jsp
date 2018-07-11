<!-- 07.10 송원민 ArryList배열을 통한 회원주소,회원번호,내용을 화면에 출력-->
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
		
			int no = Integer.parseInt(request.getParameter("no")); //memberList.jsp 에서 받은 회원번호 값
			
			MemberAddrDao addr = new MemberAddrDao();
			
			ArrayList<MemberAddr> result = addr.addrList(no);
			for(int i=0; i<result.size(); i++) {
		%>
		
		<table border="1">
			<tr>
				<td>회원주소번호</td>
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
		
		<a href="<%= request.getContextPath() %>/Member/memberList.jsp">돌아가기</a>
	</body>
</html>