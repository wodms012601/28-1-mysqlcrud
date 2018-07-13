<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int studentNo = Integer.parseInt(request.getParameter("studentNo")); //수정폼 페이지에서 넘겨받은 학생번호 데이터를 변수에 저장
	String studentAddrContent = request.getParameter("studentAddrContent"); //수정폼 페이지에서 넘겨받은 학생주소 데이터를 변수에 저장
	
	//학생주소 객체 생성 및 set메소드를 통해 데이터 삽입
	StudentAddr stuAddr = new StudentAddr();
	stuAddr.setStudentNo(studentNo);
	stuAddr.setStudentAddrContent(studentAddrContent);
	System.out.println("학생주소 수정 완료");
	
	//학생주소 테이블에 수정
	StudentAddrDao stuAddrDao = new StudentAddrDao();
	stuAddrDao.updateStudentAddr(stuAddr); //학생번호와 학생주소 데이터가 저장된 학생주소 객체의 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>