<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int employerNo = Integer.parseInt(request.getParameter("employerNo")); //직원 번호 데이터
	int empScore = Integer.parseInt(request.getParameter("employerScore")); //직원 점수 데이터
	
	EmployerScore employerScore = new EmployerScore(); //직원 번호와 직원 점수 데이터를 저장하기위한 직원점수 객체 생성
	employerScore.setEmployerNo(employerNo); //직원 번호
	employerScore.setScore(empScore); //직원 점수
	
	EmployerScoreDao score = new EmployerScoreDao();
	score.insertScore(employerScore); //db의 직원점수테이블에 직원점수를 저장하기위한 메서드를 호출하면서 직원점수 객체의 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>