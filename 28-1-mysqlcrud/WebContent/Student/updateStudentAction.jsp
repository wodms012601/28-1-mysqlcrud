<!-- 탁재은, 2018.07.03 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR로 인코딩
	request.setCharacterEncoding("EUC-KR");

	int studentNo = Integer.parseInt(request.getParameter("no"));

	//Student클래스를 통해 객체 생성 및 set메소드를 통해 데이터 수정
	Student stu = new Student();
	stu.setStudentNo(studentNo); //학생 넘버
	stu.setStudentName(request.getParameter("studentName")); //학생이름
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //학생나이
	System.out.println("이름,나이 수정 완료");
	
	//학생 테이블에 수정
	StudentDao stuDao = new StudentDao();
	stuDao.updateStudent(stu);
	
	
	//주소는 다른 테이블에 저장하기위해 StudentAddr클래스를 통해 객체 생성
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(studentNo); //학생 넘버
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //학생 주소데이터
	System.out.println("주소 수정 완료");
	
	//학생주소 테이블에 수정
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.updateStudentAddr(addr);
	
	response.sendRedirect(request.getContextPath()+"/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>