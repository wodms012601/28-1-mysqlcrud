<!-- 탁재은, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR로 인코딩
	request.setCharacterEncoding("EUC-KR");

	//Student클래스를 통해 객체 생성 및 set메소드를 통해 데이터 삽입
	Student stu = new Student();
	stu.setStudentName(request.getParameter("studentName"));
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge")));
	System.out.println("입력 완료");
	
	//실행
	StudentDao st = new StudentDao();
	st.insertStudent(stu);
%>