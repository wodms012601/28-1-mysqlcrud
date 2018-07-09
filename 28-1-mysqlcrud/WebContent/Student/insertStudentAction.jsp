<!-- 탁재은, 2018.07.09 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//EUC-KR로 인코딩
	request.setCharacterEncoding("EUC-KR");

	//학생 객체 생성 및 set메소드를 통해 데이터 삽입
	Student stu = new Student();
	stu.setStudentName(request.getParameter("studentName")); //학생이름
	stu.setStudentAge(Integer.parseInt(request.getParameter("studentAge"))); //학생나이
	System.out.println("이름,나이 입력 완료");
	
	//학생 테이블에 저장
	StudentDao stuDao = new StudentDao();
	/*학생이름과 나이 데이터가 저장된 학생 객체의 주소값을 매개변수로 대입
	 학생넘버데이터가 저장된 학생 객체의 주소값을 리턴받아서 객체참조변수에 대입*/
	Student student = stuDao.insertStudent(stu);
	
	
	//주소는 다른 테이블에 저장하기위해 학생 주소객체 생성
	StudentAddr addr = new StudentAddr();
	addr.setStudentNo(student.getStudentNo()); //학생 객체의 학생 번호 데이터
	System.out.println(student.getStudentNo() + "<--확인용");
	
	addr.setStudentAddrContent(request.getParameter("studentAddrContent")); //학생 주소
	System.out.println("주소 입력 완료");
	
	//학생주소 테이블에 저장
	StudentAddrDao addrDao = new StudentAddrDao();
	addrDao.insertStudentAddr(addr); //학생 번호데이터와 학생 주소 데이터가 저장된 학생 주소객체 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath() + "/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>