<!-- Ź����, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR�� ���ڵ�
	request.setCharacterEncoding("EUC-KR");

	//StudentŬ������ ���� ��ü ���� �� set�޼ҵ带 ���� ������ ����
	Student stu = new Student();
	stu.setStudentName(request.getParameter("studentName"));
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge")));
	System.out.println("�Է� �Ϸ�");
	
	//����
	StudentDao st = new StudentDao();
	st.insertStudent(stu);
%>