<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teacher List Above Avg</title>
<style>
body {
width:800px;
margin:0 auto;
}

#header {
margin:0 0 10px 0;
padding:10px;
border:1px solid #000;
background-color:#DAD9FF;
width:800px;
}

#content {
float:left;
padding:10px;
background-color:#D4F4FA;
border:1px solid #000;
width:800px;
margin-bottom:10px;
}

#sidebar_a {
float:left;
padding:10px;
border:1px solid #000;
width:800px;
background-color:#D9E5FF;
}

#footer {
clear:both;
padding:10px;
border:1px solid #000;
background-color:#E8D9FF;
width:800px;
}
</style>
</head>
<body>
	<div id="header">
		<h1>Teacher List Above Avg</h1>
	</div>
	
	<div id="sidebar_a">
		<ul>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">선생님 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherAddrList.jsp">주소 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">점수 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherListAboveAvg.jsp">평균점수 이상 리스트</a></li>
		</ul>
	</div>
<%
	TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
	int scoreAvg = teacherScoreDao.selectScoreAvg();
	
	ArrayList<TeacherAndScore> list = teacherScoreDao.selectTeacherListAboveAVG();
%>
	<div id="content">
		<div>
			평균 : <%=scoreAvg%>
		</div>
		<table border="1">
			<thead>
				<tr>
					<th>teacher_no</th>
					<th>teacher_name</th>
					<th>teacher_age</th>
					<th>teacher_score</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(int i=0; i<list.size(); i++) {
				%>
					<tr>
						<td><%=list.get(i).getTeacher().getTeacher_no()%></td>
						<td><%=list.get(i).getTeacher().getTeacherName()%></td>
						<td><%=list.get(i).getTeacher().getTeacherAge()%></td>
						<td><%=list.get(i).getTeacherScore().getScore()%></td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">돌아가기</a>
	</div>
	
	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
</body>
</html>