<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teacher Addr List</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
 	<div id="header">
		<h1>Select Teacher Addr</h1>
	</div>
	
	<div id="sidebar_a">
		<ul>
			<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp">선생님 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAddrList.jsp">주소 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">점수 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreAboveAvgList.jsp">평균점수 이상 리스트</a></li>
		</ul>
	</div>
	
	
<%					
	int send_id = Integer.parseInt(request.getParameter("send_id"));
	TeacherAddrDao teacherAddrDao = new TeacherAddrDao();
	TeacherAddr ta = teacherAddrDao.infoTeacherAddr(send_id);
%>	

	<div id="content">
		<table border="1">
			<thead>
				<tr>
					<th>주소번호</th>
					<th>선생님번호</th>
					<th>선생님주소</th>
				</tr>
			</thead>
			<tbody>
			<tr>
				<td><%=ta.getTeacher_addr_no()%></td>
				<td><%=ta.getTeacher_no()%></td>
				<td><%=ta.getTeacher_addr_content()%></td>
			</tr>
		</table>
		<br>
		<br>
		<br>
		<a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp">돌아가기</a>
	</div>

	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
</body>
</html>