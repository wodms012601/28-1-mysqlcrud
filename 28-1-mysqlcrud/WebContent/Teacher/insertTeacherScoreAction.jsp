<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert Teacher Score Action</title>
<%
	TeacherScore teacherScore = new TeacherScore();
	teacherScore.setTeacherNo(Integer.parseInt(request.getParameter("teacher_no")));
	teacherScore.setScore(Integer.parseInt(request.getParameter("score")));
		
	TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
	teacherScoreDao.insertScore(teacherScore);
	response.sendRedirect(request.getContextPath() + "/Teacher/teacherList.jsp");
%>