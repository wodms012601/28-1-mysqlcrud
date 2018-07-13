<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<!DOCTYPE html>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	
	MemberScoreDao dao = new MemberScoreDao();
	MemberScore m = dao.selectScore(no);
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
		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberList.jsp">회원 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAddrList.jsp">회원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAndScoreList.jsp">회원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAndScoreAboveAvgList.jsp">평균점수이상의 회원 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<div><h3><%=name %>님의 점수정보 입니다.</h3></div>
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
		
			<div><a href="<%=request.getContextPath() %>/Member/insertMemberForm.jsp">학생 정보 입력 페이지</a></div>
		</div>
		
		<div id="footer">
				COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>