<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Update Teacher Form</title>
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
		<h1>Update Teacher Form</h1>
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
	String send_id = request.getParameter("send_id");
	System.out.println(send_id);
	TeacherDao teacherdao = new TeacherDao();
	Teacher t = teacherdao.selectForUpdateTeacher(send_id);
%>

	<div id="content">
		<form action="<%=request.getContextPath()%>/Teacher/updateTeacherAction.jsp" method="post" >
			<table>
				<tr>
					<td>teacher_no</td>
					<td><input type="text" name="teacher_no" value=<%=send_id%> readonly="readonly" ></td>
				</tr>
				<tr>
					<td>teacher_name</td>
					<td><input type="text" name="teacher_name" value=<%=t.getTeacherName()%>></td>
				</tr>
				<tr>
					<td>teacher_age</td>
					<td><input type="text" name="teacher_age" value=<%=t.getTeacherAge()%>></td>
				</tr>
			</table>
			<input type="submit" value="수정">
		</form>
	</div>
	
	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
</body>
</html>