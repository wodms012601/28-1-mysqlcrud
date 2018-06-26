<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>insertTeacherForm</title>
<style type = "text/css">
	#box {width:300px;}
	#box label {display:black; width:100px; float:left;}
</style>
</head>
<body>
<form action = "<%= request.getContextPath() %>/insertTeacherAction.jsp" method="post">
	<fieldset id = "box">
		<legend>insert Teacher Form</legend>
		
		<label for="1">teacherName</label>
		<input type = "text" name = "teacherName"/> <br/>
		
		<label for="2">teacherAge</label>
		<input type = "text" name = "teacherAge"/> <br/> <br/>
		
		<input type = "submit" value = "insert">
	</fieldset>
</form>

</body>
</html>