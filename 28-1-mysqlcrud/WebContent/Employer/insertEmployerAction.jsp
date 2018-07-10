<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	//고용주 객체 생성 및 set메소드를 통해 데이터 삽입
	Employer emp = new Employer();
	emp.setEmployerName(request.getParameter("employerName")); //고용주이름
	emp.setEmployerAge(Integer.parseInt(request.getParameter("employerAge"))); //고용주나이
	System.out.println("이름,나이 입력 완료");
	
	//고용주 테이블에 저장
	EmployerDao dao = new EmployerDao();
	//고용주이름과 나이 데이터가 저장된 고용주 객체의 주소값을 매개변수로 대입
	dao.insertEmployer(emp);
%>