<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int employerNo = Integer.parseInt(request.getParameter("no")); //리스트 페이지에서 넘겨받은 직원 번호 데이터를 변수에 저장

	EmployerAddrDao studentAddrDao = new EmployerAddrDao(); 
	studentAddrDao.deleteEmployerAddr(employerNo); //직원주소테이블의 employer_no가 외래키로서 직원 테이블에 종속되어있었기때문에 직원주소테이블을 먼저 삭제를 한다.
	
	EmployerScoreDao employerScoreDao = new EmployerScoreDao(); 
	employerScoreDao.deleteEmployerScore(employerNo); //직원점수테이블의 employer_no가 외래키로서 직원 테이블에 종속되어있었기때문에 직원점수테이블을 먼저 삭제를 한다.
	
	EmployerDao employerDao = new EmployerDao();
	employerDao.deleteEmployer(employerNo); //직원 테이블의 데이터 삭제
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>
