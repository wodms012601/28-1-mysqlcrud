<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int employerNo = Integer.parseInt(request.getParameter("employerNo")); //수정폼 페이지에서 넘겨받은 직원번호 데이터를 변수에 저장
	
	//직원주소 객체 생성 및 set메소드를 통해 데이터 삽입
	EmployerAddr empAddr = new EmployerAddr();
	empAddr.setEmployerNo(employerNo);
	empAddr.setEmployerAddrContent(request.getParameter("employerAddrContent"));
	System.out.println("직원주소 수정 완료");
	
	//직원주소 테이블에 수정
	EmployerAddrDao empAddrDao = new EmployerAddrDao();
	empAddrDao.updateEmployerAddr(empAddr); //직원번호와 직원주소 데이터가 저장된 직원주소 객체의 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>