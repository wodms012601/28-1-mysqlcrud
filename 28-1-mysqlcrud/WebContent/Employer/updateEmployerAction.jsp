<!-- 탁재은, 2018.07.09 -->
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR로 인코딩
	request.setCharacterEncoding("UTF-8");
	
	int employerNo = Integer.parseInt(request.getParameter("employerNo"));
	
	//고용주 객체 생성 및 set메소드를 통해 데이터 삽입
	Employer emp = new Employer();
	emp.setEmployerNo(employerNo); //고용주 번호
	emp.setEmployerName(request.getParameter("employerName")); //고용주 이름
	emp.setEmployerAge(Integer.parseInt(request.getParameter("employerAge"))); //고용주 나이
	System.out.println("이름,나이 수정 완료");
	
	//고용주 테이블에 수정
	EmployerDao empDao = new EmployerDao();
	empDao.updateEmployer(emp); //고용주번호와 고용주이름, 나이 데이터가 저장된 고용주 객체의 주소값을 매개변수로 대입
	
	
	//주소는 다른 테이블에 저장하기위해 학생 주소객체 생성
	EmployerAddr empAddr = new EmployerAddr();
	empAddr.setEmployerNo(employerNo); //고용주 번호 데이터
	empAddr.setEmployerAddrContent(request.getParameter("employerAddrContent")); //고용주 주소데이터
	System.out.println("주소 수정 완료");
	
	//고용주주소 테이블에 수정
	EmployerAddrDao addrDao = new EmployerAddrDao();
	addrDao.updateEmployerAddr(empAddr); //고용주 번호데이터와 고용주 주소 데이터가 저장된 고용주 주소객체 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>