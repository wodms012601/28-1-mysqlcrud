<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int studentNo = Integer.parseInt(request.getParameter("studentNo")); //리스트 페이지에서 넘겨받은 학생 번호 데이터를 변수에 저장

	//학생 주소객체 생성
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(studentNo); //학생 번호
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //학생 주소
	System.out.println("주소 입력 완료");
	
	//학생주소 테이블에 저장
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.insertStudentAddr(addr); //학생번호 데이터와 학생주소 데이터가 저장된 학생 주소객체 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath() + "/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>
