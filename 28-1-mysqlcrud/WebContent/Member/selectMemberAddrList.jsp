<!-- 07.10 송원민 ArryList배열을 통한 회원주소,회원번호,내용을 화면에 출력-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
	<head>
		<title>회원주소 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>회원주소 리스트</h1>
		</div>
		<div id="content">
			<table border="1">
				<tr>
					<th>주소번호</th>
					<th>회원주소번호</th>
					<th>회원주소</th>
				</tr>
		<%
			request.setCharacterEncoding("euc-kr");
		
			int no = Integer.parseInt(request.getParameter("no")); //memberList.jsp 에서 받은 회원번호 값
			
			MemberAddrDao addr = new MemberAddrDao();
			
			ArrayList<MemberAddr> result = addr.addrList(no);
			for(int i=0; i<result.size(); i++) {
		%>
				<tr>
					<td><%=result.get(i).getMember_addr_no() %></td>
					<td><%=result.get(i).getMember_no() %></td>
					<td><%=result.get(i).getMember_addr_content() %></td>
				</tr>
		<%		
			}
		%>
			</table>
		
			<div>
			</div><br>
		</div>
		
		<div id="footer">
				COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>