<!-- 28th Choi Yun-Seok, 2018.07.9 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert Teacher Addr Action</title>
<%
	TeacherAddr t = new TeacherAddr();
	t.setTeacher_no(Integer.parseInt(request.getParameter("teacher_no")));
	t.setTeacher_addr_content(request.getParameter("teacher_addr_content"));
		
	TeacherAddrDao teacherAddrDao = new TeacherAddrDao();
	teacherAddrDao.insertTeacherAdd(t);
	response.sendRedirect(request.getContextPath() + "/Teacher/teacherList.jsp");
%>