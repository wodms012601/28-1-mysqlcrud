<!-- Ź����, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<% request.setCharacterEncoding("EUC-KR"); %>

<!-- vo��ü ���� �� ������ �Է� -->
<jsp:useBean id="stu" class="service.Student"/>
<jsp:setProperty property="*" name="stu"/>
<%
	//����
	StudentDao st = new StudentDao();
	st.insertStudent(stu);
%>