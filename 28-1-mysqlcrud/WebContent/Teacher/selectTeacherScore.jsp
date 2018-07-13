<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>선생님 개인 점수 검색</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
 	<div id="header">
		<h1>선생님 개인 점수 검색</h1>
	</div>

<%					
	int send_id = Integer.parseInt(request.getParameter("send_id"));
	TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
	TeacherScore teacherScore = teacherScoreDao.selectTeacherScore(send_id);
%>	
	<div id="content">
		<table border="1">
			<thead>
				<tr>
					<th>점수번호</th>
					<th>선생님번호</th>
					<th>선생님점수</th>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td><%=teacherScore.getTeacherScoreNo()%></td>
				<td><%=teacherScore.getTeacherNo()%></td>
				<td><%=teacherScore.getScore()%></td>
			</tr>
		</table>
	</div>

	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
</body>
</html>