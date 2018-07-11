<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teacher And Score List</title>
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
		<h1>Teacher And Score List</h1>
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
		request.setCharacterEncoding("UTF-8");

		TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
		ArrayList<TeacherAndScore> arrayList = teacherScoreDao.selectTeacherAndScored();	
	%>
		
	<div id="content">
			<table border="1">
				<tr>
					<th>teacher_no</th>
					<th>teacher_name</th>
					<th>teacher_age</th>
					<th>score</th>
				</tr>
				<%
					for(int i=0; i<arrayList.size(); i++){			
				%>
						<tr>
							<td><%=arrayList.get(i).getTeacherScore().getTeacherNo()%></td>
							<td><%=arrayList.get(i).getTeacher().getTeacherName()%></td>
							<td><%=arrayList.get(i).getTeacher().getTeacherAge()%></td>
							<td><%=arrayList.get(i).getTeacherScore().getScore()%></td>
						</tr>
				<%
					}
				%>
			</table>
	
			<a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">돌아가기</a>
	</div>
	
	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
	</body>
</html>