<!-- 탁재은, 2018.07.12 -->
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR로 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int employerNo = Integer.parseInt(request.getParameter("no")); //수정폼 페이지에서 넘겨받은 직원 번호 데이터를 변수에 저장
	
	//직원 객체 생성 및 set메소드를 통해 데이터 삽입
	Employer emp = new Employer();
	emp.setEmployerNo(employerNo); //직원 번호
	emp.setEmployerName(request.getParameter("employerName")); //직원 이름
	emp.setEmployerAge(Integer.parseInt(request.getParameter("employerAge"))); //직원 나이
	System.out.println("직원이름,나이 수정 완료");
	
	//직원 테이블에 수정
	EmployerDao empDao = new EmployerDao();
	empDao.updateEmployer(emp); //직원번호와 직원이름, 나이 데이터가 저장된 직원 객체의 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>