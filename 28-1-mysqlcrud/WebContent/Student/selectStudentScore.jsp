<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no")); //학생 리스트에서 받은 학생 번호데이터를 변수에 대입

	StudentScoreDao studentScoreDao = new StudentScoreDao();
	//학생 번호 데이터가 저장된 변수를 매개변수로 대입하고 학생주소 데이터들이 저장된 학생주소 객체의 주소값을 리턴받는다.
	StudentScore studentScore = studentScoreDao.selectStudentScore(studentNo);
%>
<html>
	<head>
		<title>학생 개인 점수 검색</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>학생 개인 점수 검색</h1>
		</div>
		<div id="content">
			<table border="1">
				<tr>
					<th>점수번호</th>
					<th>학생번호</th>
					<th>학생점수</th>
				</tr>
				<tr>
					<td><%=studentScore.getStudentScoreNo() %></td>
					<td><%=studentScore.getStudentNo() %></td>
					<td><%=studentScore.getScore() %></td>
				</tr>
			</table>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>