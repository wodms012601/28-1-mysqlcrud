<!-- 28th Choi Yun-Seok, 2018.06.26 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.TeacherDao" %>
<%@ page import = "service.Teacher" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<!DOCTYPE html>

<%
	Teacher t = new Teacher();
	t.setTeacherName(request.getParameter("teacherName"));
	t.setTeacherAge(Integer.parseInt(request.getParameter("teacherAge")));
	
	System.out.println(t.getTeacherName() + "<-- teacherName");
	System.out.println(t.getTeacherAge() + "<-- teacherAge");
	
	TeacherDao tdao = new TeacherDao();
	tdao.insertTeacher(t);
%>