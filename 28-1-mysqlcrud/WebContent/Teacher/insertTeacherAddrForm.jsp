<!-- 28th Choi Yun-Seok, 2018.07.03 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
<style type = "text/css">
	#box {width:300px;}
	#box label {display:black; width:100px; float:left;}
</style>
</head>
<body>

<%
	String send_id = request.getParameter("send_id");
%>
	
	<form action = "<%= request.getContextPath() %>/Teacher/insertTeacherAddrAction.jsp" method="post">
		<fieldset id = "box">
			<legend>insert Teacher Addr Form</legend>
			
			<label for="1">teacher_no</label>
			<input type = "text" name = "teacher_no" value=<%=send_id%> readonly="readonly"> <br/>
			
			<label for="2">teacher_addr_content</label>
			<input type = "text" name = "teacher_addr_content"> <br/> <br/>
			
			<input type = "submit" value = "insert">
		</fieldset>
</form>

</body>
</html>