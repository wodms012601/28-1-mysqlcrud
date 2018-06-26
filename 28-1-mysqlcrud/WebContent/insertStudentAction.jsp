<!-- 탁재은, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<% request.setCharacterEncoding("EUC-KR"); %>

<!-- vo객체 생성 및 데이터 입력 -->
<jsp:useBean id="stu" class="service.Student"/>
<jsp:setProperty property="*" name="stu"/>
<%
	//실행
	StudentDao st = new StudentDao();
	st.insertStudent(stu);
%>