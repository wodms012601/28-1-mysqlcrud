<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
<%	
	TeacherAddr teacherAddr = new TeacherAddr();
	teacherAddr.setTeacher_no(Integer.parseInt(request.getParameter("teacherNo")));
	teacherAddr.setTeacher_addr_content(request.getParameter("teacher_addr_content"));;

	TeacherAddrDao teacherAddrDao = new TeacherAddrDao();
	
	teacherAddrDao.updateTeacherAddr(teacherAddr);
	response.sendRedirect(request.getContextPath() + "/Teacher/teacherList.jsp");
%>