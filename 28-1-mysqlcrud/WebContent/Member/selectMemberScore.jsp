<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<!DOCTYPE html>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	
	MemberScoreDao dao = new MemberScoreDao();
	MemberScore m = dao.selectMemberScore(no);
%>
<html>
	<head>
		<title>회원점수 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>회원점수 리스트</h1>
		</div>
		<div id="content">
			<table border="1">
				<thead>
					<tr>
						<th>회원점수번호</th>
						<th>회원번호</th>
						<th>회원점수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=m.getMemberScoreNo()%></td>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getScore()%></td>
					</tr>
				</tbody>
			</table>
			<div>
			</div><br>
		<div id="footer">
				COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>