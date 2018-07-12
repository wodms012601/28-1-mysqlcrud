<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int employerNo = Integer.parseInt(request.getParameter("employerNo")); //수정폼 페이지에서 넘겨받은 직원번호 데이터를 변수에 저장
	int employerScore = Integer.parseInt(request.getParameter("employerScore")); //수정폼 페이지에서 넘겨받은 직원점수 데이터를 변수에 저장
	
	//직원점수 객체 생성 및 set메소드를 통해 데이터 삽입
	EmployerScore empScore = new EmployerScore();
	empScore.setEmployerNo(employerNo);
	empScore.setScore(employerScore);
	System.out.println("직원점수 수정 완료");
	
	//직원점수 테이블에 수정
	EmployerScoreDao empScoreDao = new EmployerScoreDao();
	empScoreDao.updateEmployerScore(empScore); //직원번호와 직원점수 데이터가 저장된 직원점수 객체의 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>