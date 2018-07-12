<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int studentNo = Integer.parseInt(request.getParameter("studentNo")); //수정폼 페이지에서 넘겨받은 학생번호 데이터를 변수에 저장
	int studentScore = Integer.parseInt(request.getParameter("studentScore")); //수정폼 페이지에서 넘겨받은 학생점수 데이터를 변수에 저장
	
	//학생점수 객체 생성 및 set메소드를 통해 데이터 삽입
	StudentScore stuScore = new StudentScore();
	stuScore.setStudentNo(studentNo);
	stuScore.setScore(studentScore);
	System.out.println("학생점수 수정 완료");
	
	//학생점수 테이블에 수정
	StudentScoreDao stuScoreDao = new StudentScoreDao();
	stuScoreDao.updateStudentScore(stuScore); //학생번호와 학생점수 데이터가 저장된 학생점수 객체의 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Student/studentList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>