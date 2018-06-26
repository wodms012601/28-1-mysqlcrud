<!-- 최윤석, 2018.06.26 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.TeacherDao" %>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="t" class="service.Teacher"/>
<jsp:setProperty name="t" property="*" />
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>insertTeacherAction</title>
</head>
<body>
<%
	System.out.println(t.getTeacherName() + "<-- teacherName");
	System.out.println(t.getTeacherAge() + "<-- teacherAge");
	
	TeacherDao tdao = new TeacherDao();
	tdao.insertTeacher(t);
%>
</body>
</html>