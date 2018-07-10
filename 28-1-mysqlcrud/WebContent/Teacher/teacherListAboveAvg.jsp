<!-- 28th Choi Yun-Seok, 2018.07.10 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>teacherListAboveAvg</title>
</head>
<body>

<%
	TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
	int scoreAvg = teacherScoreDao.selectScoreAvg();
	
	ArrayList<TeacherAndScore> list = teacherScoreDao.selectTeacherListAboveAVG();
%>
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
</body>
</html>