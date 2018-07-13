<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>


<%
	String send_id = request.getParameter("send_id");
	TeacherDao teacherdao = new TeacherDao();
	teacherdao.deleteTeacher(send_id);
	response.sendRedirect(request.getContextPath() + "/Teacher/teacherList.jsp");
%>
