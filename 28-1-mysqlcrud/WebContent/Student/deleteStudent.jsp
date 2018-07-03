<!-- 탁재은, 2018.07.03 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no"));

	StudentAddrDao studentAddrDao = new StudentAddrDao(); 
	studentAddrDao.deleteStudentAddr(studentNo); //주소테이블의 student_no가 외래키로서 종속되어있었기때문에 먼저 삭제를 한다.
	
	StudentDao studentdao = new StudentDao();
	studentdao.deleteStudent(studentNo); //학생 테이블의 데이터 삭제
	
	response.sendRedirect(request.getContextPath()+"/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>