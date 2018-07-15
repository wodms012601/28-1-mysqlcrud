<!-- 탁재은, 2018.07.09 -->
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	//학생 객체 생성 및 set메소드를 통해 데이터 삽입
	Student stu = new Student();
	stu.setStudentName(request.getParameter("studentName")); //학생이름
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //학생나이
	System.out.println("학생이름,나이 입력 완료");
	
	StudentDao stuDao = new StudentDao();
	//학생이름과 나이 데이터가 저장된 학생 객체의 주소값을 매개변수로 대입
	stuDao.insertStudent(stu);
	
	response.sendRedirect(request.getContextPath() + "/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>