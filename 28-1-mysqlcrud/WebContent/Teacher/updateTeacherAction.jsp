<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	
<%	
	Teacher t = new Teacher();
	t.setTeacher_no(Integer.parseInt(request.getParameter("teacher_no")));
	t.setTeacherName(request.getParameter("teacher_name"));
	t.setTeacherAge(Integer.parseInt(request.getParameter("teacher_age")));;

	TeacherDao teacherDao = new TeacherDao();
	
	teacherDao.updateTeacher(t);
	response.sendRedirect(request.getContextPath() + "/Teacher/selectTeacherList.jsp");
%>