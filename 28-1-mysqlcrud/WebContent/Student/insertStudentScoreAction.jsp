<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("studentNo")); //학생 번호 데이터
	int stuScore = Integer.parseInt(request.getParameter("studentScore")); //학생 점수 데이터
	
	StudentScore studentScore = new StudentScore(); //학생 번호와 학생 점수 데이터를 저장하기위한 학생점수 객체 생성
	studentScore.setStudentNo(studentNo); //학생 번호
	studentScore.setScore(stuScore); //학생 점수
	
	StudentScoreDao score = new StudentScoreDao();
	score.insertScore(studentScore); //db의 학생점수테이블에 학생점수를 저장하기위한 메서드를 호출하면서 학생점수 객체의 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>