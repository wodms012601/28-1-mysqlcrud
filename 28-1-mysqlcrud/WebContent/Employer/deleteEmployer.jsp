<!-- 탁재은, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int employerNo = Integer.parseInt(request.getParameter("no")); //리스트 페이지에서 넘겨받은 고용주 번호 데이터를 변수에 저장

	EmployerAddrDao studentAddrDao = new EmployerAddrDao(); 
	studentAddrDao.deleteEmployerAddr(employerNo); //주소테이블의 employerNo가 외래키로서 종속되어있었기때문에 주소테이블을 먼저 삭제를 한다.
	
	EmployerDao employerDao = new EmployerDao();
	employerDao.deleteEmployer(employerNo); //고용주 테이블의 데이터 삭제
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>
