<!-- 28th Choi Yun-Seok, 2018.07.9 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>insertTeacherForm</title>
<style type = "text/css">
	#box {width:300px;}
	#box label {display:black; width:100px; float:left;}
</style>
</head>
<body>
<%
	String send_id = request.getParameter("send_id");
%>
<form action = "<%= request.getContextPath() %>/Teacher/insertTeacherScoreAction.jsp" method="post">
	<fieldset id = "box">
		<legend>insert Teacher Score Form</legend>
		
		<label for="1">teacher_no</label>
		<input type = "text" name = "teacher_no" value=<%=send_id%> readonly="readonly"> <br/>
		
		<label for="2">Score</label>
		<input type = "text" name = "score"/> <br/> <br/>
		
		<input type = "submit" value = "insert">
	</fieldset>
</form>

</body>
</html>