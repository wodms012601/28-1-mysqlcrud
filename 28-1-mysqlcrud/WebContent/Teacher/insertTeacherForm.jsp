<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Insert Teacher Addr Form</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
<style type = "text/css">
	#box {width:300px;}
	#box label {display:black; width:100px; float:left;}
</style>
</head>
<body>
	<div id="header">
		<h1>Insert Teacher Form</h1>
	</div>

	<div id="sidebar_a">
		<ul>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">선생님 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherAddrList.jsp">주소 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">점수 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherListAboveAvg.jsp">평균점수 이상 리스트</a></li>
		</ul>
	</div>

	<div id="content">
		<form action = "<%= request.getContextPath() %>/Teacher/insertTeacherAction.jsp" method="post">
			<fieldset id = "box">
				<legend><h3>Insert Teacher Form</h3></legend>
					<br>
					<br>
					<label for="1">teacherName</label>
					<input type = "text" name = "teacherName" required /> <br/>
				
					<label for="2">teacherAge</label>
					<input type = "text" name = "teacherAge" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required /> <br/> <br/>
					<!-- onkeydown = 키를 눌렀을 때 발생하는 이벤트 / onkeyup = 눌렀던 키를 때면 발생하는 이벤트 -->
					<!-- onkeydown="return showKeyCode(event)" 과 같이 하면 showKeyDown 함수를 호출해서 결과가 true이면 본래의 동작을 그대로 수행하고 false이면 본래의 동작을 중단시킨다 -->
					<input type = "submit" value = "insert">
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