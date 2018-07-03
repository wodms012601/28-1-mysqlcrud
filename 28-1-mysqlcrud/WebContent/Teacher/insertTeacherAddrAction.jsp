<!-- 28th Choi Yun-Seok, 2018.07.03 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
<%
	TeacherAddr t = new TeacherAddr();
	t.setTeacher_no(Integer.parseInt(request.getParameter("teacher_no")));
	t.setTeacherAddrContent(request.getParameter("teacher_addr_content"));
		
	TeacherDao teacherdao = new TeacherDao();
	teacherdao.insertTeacherAdd(t);
	response.sendRedirect(request.getContextPath() + "/Teacher/selectTeacherAddrList.jsp");
%>