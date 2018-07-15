<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int employerNo = Integer.parseInt(request.getParameter("employerNo")); //리스트 페이지에서 넘겨받은 직원 번호 데이터를 변수에 저장

	//직원 주소객체 생성
	EmployerAddr addr = new EmployerAddr();
	addr.setEmployerNo(employerNo); //직원 번호
	addr.setEmployerAddrContent(request.getParameter("employeraddrContent")); //직원 주소
	System.out.println("주소 입력 완료");
	
	//직원주소 테이블에 저장
	EmployerAddrDao addrDao = new EmployerAddrDao();
	addrDao.insertEmployerAddr(addr); //직원번호 데이터와 직원주소 데이터가 저장된 직원 주소객체 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath() + "/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>
