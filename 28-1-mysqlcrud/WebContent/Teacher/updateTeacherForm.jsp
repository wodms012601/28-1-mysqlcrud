<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Update Teacher Form</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
<style>
#box {width:300px;}
#box label {display:black; width:100px; float:left;}
</style>
</head>
<body>
	<div id="header">
		<h1>Update Teacher Form</h1>
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
	String send_id = request.getParameter("send_id");
	System.out.println(send_id);
	TeacherDao teacherdao = new TeacherDao();
	Teacher t = teacherdao.selectForUpdateTeacher(send_id);
%>

	<div id="content">
		<form action="<%=request.getContextPath()%>/Teacher/updateTeacherAction.jsp" method="post" >
			<fieldset id = "box">
				<legend><h3>Update Teacher Form</h3></legend>
					<br>
					<br>
					<label for="1">teacher_no</label>
					<input type="text" name="teacher_no" value=<%=send_id%> readonly="readonly" >

					<label for="2">teacher_name</label>
					<input type="text" name="teacher_name" value=<%=t.getTeacherName()%> required>

					<label for="3">teacher_age</label>
					<input type="text" name="teacher_age" value=<%=t.getTeacherAge()%> onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required>

				<input type="submit" value="수정">
				<br>
				<br>
			</fieldset>
		</form>
	</div>

	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
	<script src="<%= request.getContextPath() %>/script/main.js"></script>
</body>
</html>