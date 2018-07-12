<!-- 탁재은, 2018.07.12 -->
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int studentNo = Integer.parseInt(request.getParameter("no")); //수정폼 페이지에서 넘겨받은 학생 번호 데이터를 변수에 저장

	//학생 객체 생성 및 set메소드를 통해 데이터 삽입
	Student stu = new Student();
	stu.setStudentNo(studentNo); //학생 번호
	stu.setStudentName(request.getParameter("studentName")); //학생이름
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //학생나이
	System.out.println("이름,나이 수정 완료");
	
	//학생 테이블에 수정
	StudentDao stuDao = new StudentDao();
	stuDao.updateStudent(stu); //학생번호와 학생이름, 나이 데이터가 저장된 학생 객체의 주소값을 매개변수로 대입
	
	
	//주소는 다른 테이블에 저장하기위해 학생 주소객체 생성
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(studentNo); //학생 번호 데이터
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //학생 주소데이터
	System.out.println("주소 수정 완료");
	
	//학생주소 테이블에 수정
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.updateStudentAddr(addr); //학생 번호데이터와 학생 주소 데이터가 저장된 학생 주소객체 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>