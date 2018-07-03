<!-- 탁재은, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR로 인코딩
	request.setCharacterEncoding("EUC-KR");

	//Student클래스를 통해 객체 생성 및 set메소드를 통해 데이터 삽입
	Student stu = new Student();
	stu.setStudentName(request.getParameter("studentName")); //학생이름
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //학생나이
	System.out.println("이름,나이 입력 완료");
	
	//학생 테이블에 저장
	StudentDao stuDao = new StudentDao();
	Student student = stuDao.insertStudent(stu);
	
	
	//주소는 다른 테이블에 저장하기위해 StudentAddr클래스를 통해 객체 생성
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(student.getStudentNo());
	System.out.println(student.getStudentNo() + "<--확인용"); //학생 번호
	
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //학생 주소데이터
	System.out.println("주소 입력 완료");
	
	//학생주소 테이블에 저장
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.insertStudentAddr(addr);
%>