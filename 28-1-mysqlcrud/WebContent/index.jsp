<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>메인페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>메인 페이지</h1>
		</div>
		<div id="sidebar_a">
			<div><h3>학생 리스트(탁재은)</h3></div>
			<ul>
				<li><a href="<%=request.getContextPath() %>/Student/studentList.jsp">학생 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAddrList.jsp">학생주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp">학생점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAndScoreAboveAvgList.jsp">평균점수이상의 학생 리스트</a></li>
			</ul>
			<div><h3>선생님 리스트(최윤석)</h3></div>
			<ul>
				<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">선생님 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherAddrList.jsp">선생님주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">선생님점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Teacher/teacherListAboveAvg.jsp">평균점수 이상 선생님 리스트</a></li>
			</ul>
			<div><h3>직원 리스트(탁재은)</h3></div>
			<ul>
				<li><a href="<%=request.getContextPath() %>/Employer/employerList.jsp">직원 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Employer/employerAddrList.jsp">직원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Employer/employerAndScoreList.jsp">직원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Employer/employerAndScoreAboveAvgList.jsp">평균점수 이상 직원 리스트</a></li>
			</ul>
			<div><h3>멤버 리스트(송원민)</h3></div>
			<ul>
				<li><a href="<%=request.getContextPath() %>/Member/memberList.jsp">멤버 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/allMemberAddrList.jsp">멤버주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/allMemberAndScoreList.jsp">멤버점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/overMemberScoreList.jsp">평균점수 이상 멤버 리스트</a></li>
			</ul>
		</div><br>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>