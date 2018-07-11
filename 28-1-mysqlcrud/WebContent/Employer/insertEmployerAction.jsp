<!-- 탁재은, 2018.07.11 -->
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
	EmployerDao empdao = new EmployerDao();
	/*고용주이름과 나이 데이터가 저장된 고용주 객체의 주소값을 매개변수로 대입
	 고용주넘버데이터가 저장된 고용주 객체의 주소값을 리턴받아서 객체참조변수에 대입*/
	Employer employer = empdao.insertEmployer(emp);
	
	//주소는 다른 테이블에 저장하기위해 학생 주소객체 생성
	EmployerAddr addr = new EmployerAddr();
	addr.setEmployerNo(employer.getEmployerNo()); //고용주 객체의 고용주 번호 데이터
	addr.setEmployerAddrContent(request.getParameter("employerAddrContent")); //고용주 주소
	System.out.println("주소 입력 완료");
	
	//고용주주소 테이블에 저장
	EmployerAddrDao addrDao = new EmployerAddrDao();
	addrDao.insertEmployerAddr(addr); //고용주 번호데이터와 고용주 주소 데이터가 저장된 고용주 주소객체 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Employer/employerList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>