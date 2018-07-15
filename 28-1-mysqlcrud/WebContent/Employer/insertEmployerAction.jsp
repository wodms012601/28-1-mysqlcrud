<!-- 탁재은, 2018.07.12 -->
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	//직원 객체 생성 및 set메소드를 통해 데이터 삽입
	Employer emp = new Employer();
	emp.setEmployerName(request.getParameter("employerName")); //직원이름
	emp.setEmployerAge(Integer.parseInt(request.getParameter("employerAge"))); //직원나이
	System.out.println("직원이름,나이 입력 완료");
	
	//직원 테이블에 저장
	EmployerDao empdao = new EmployerDao();
	//직원이름과 나이 데이터가 저장된 직원 객체의 주소값을 매개변수로 대입
	empdao.insertEmployer(emp);
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>