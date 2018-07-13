<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.TeacherDao" %>
<%@ page import = "service.Teacher" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>

<%
	Teacher t = new Teacher();
	t.setTeacherName(request.getParameter("teacherName"));
	t.setTeacherAge(Integer.parseInt(request.getParameter("teacherAge")));
	
	System.out.println(t.getTeacherName() + "<-- teacherName");
	System.out.println(t.getTeacherAge() + "<-- teacherAge");
	
	TeacherDao tdao = new TeacherDao();
	tdao.insertTeacher(t);
	response.sendRedirect(request.getContextPath() + "/Teacher/teacherList.jsp");
%>