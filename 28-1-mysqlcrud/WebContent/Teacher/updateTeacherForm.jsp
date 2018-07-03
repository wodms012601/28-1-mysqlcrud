<!-- 28th Choi Yun-Seok, 2018.07.03 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>updateTeacherForm</title>
	
<%
	String send_id = request.getParameter("send_id");
	System.out.println(send_id);
	TeacherDao teacherdao = new TeacherDao();
	Teacher t = teacherdao.selectForUpdateTeacher(send_id);
%>

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
		</table>
	<input type="submit" value="수정">