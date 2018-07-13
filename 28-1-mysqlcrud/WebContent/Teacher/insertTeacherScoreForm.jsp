<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>선생님 점수 입력 페이지</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
	<div id="header">
		<h1>선생님 점수 입력 페이지</h1>
	</div>

<%
	String send_id = request.getParameter("send_id");
%>
		<div id="content">
			<form action="<%= request.getContextPath()%>/Teacher/insertTeacherScoreAction.jsp" method="post">
				<fieldset>
					<legend>점수입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 점수 :&nbsp;</div>
						<div>
							<input type = "text" name = "score" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required />
						</div>
							<input type = "hidden" name = "teacher_no" value=<%=send_id%> readonly="readonly">
				</fieldset><br>
				<fieldset>
					<input type = "submit" value = "점수입력">
				</fieldset>
			</form>
		</div>

		<div id="footer">
			COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>