<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Update Teacher Score Form</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
<style>
#box {width:300px;}
#box label {display:black; width:100px; float:left;}
</style>
</head>
<body>
	<div id="header">
		<h1>Update Teacher Score Form</h1>
	</div>

<%
	String send_id = request.getParameter("send_id");
	System.out.println(send_id);
	TeacherScoreDao teacherdao = new TeacherScoreDao();
	TeacherScore teacherScore = teacherdao.selectForUpdateTeacherScore(send_id);
%>

	<div id="content">
		<form action="<%=request.getContextPath()%>/Teacher/updateTeacherScoreAction.jsp" method="post" >
				<fieldset>
					<legend>점수입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 점수 :&nbsp;</div>
						<div>
							<input type="text" name="score" value=<%=teacherScore.getScore()%> onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required>
							<!-- onkeydown = 키를 눌렀을 때 발생하는 이벤트 / onkeyup = 눌렀던 키를 때면 발생하는 이벤트 -->
							<!-- onkeydown="return showKeyCode(event)" 과 같이 하면 showKeyDown 함수를 호출해서 결과가 true이면 본래의 동작을 그대로 수행하고 false이면 본래의 동작을 중단시킨다 -->
						</div>
						<input type="hidden" name="teacherNo" value=<%=teacherScore.getTeacherNo()%> readonly="readonly" required> <br/>
				</fieldset><br>
				<fieldset>
					 <input type="submit" value="점수수정">
				</fieldset>
			</form>
		</div>

		<div id="footer">
			COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>