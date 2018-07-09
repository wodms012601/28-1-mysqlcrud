<!-- 28th Choi Yun-Seok, 2018.07.9 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>

<%					
	int send_id = Integer.parseInt(request.getParameter("send_id"));
	TeacherAddrDao teacherAddrDao = new TeacherAddrDao();
	TeacherAddr ta = teacherAddrDao.infoTeacherAddr(send_id);
%>	
<table border="1">
	<tr>
		<th>teacher_addr_no</th>
		<td><%=ta.getTeacher_addr_no()%></td>
	</tr>
	<tr>
		<th>teacher_no</th>
		<td><%=ta.getTeacher_no()%></td>
	</tr>
	<tr>
		<th>teacher_addr_content</th>
		<td><%=ta.getTeacher_addr_content()%></td>
	</tr>
</table>
</body>
</html>