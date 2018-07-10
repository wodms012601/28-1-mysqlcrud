<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>메인페이지</title>
	</head>
	<body>
		<h1>index.jsp</h1>
		<ul>
			<li><a href="<%=request.getContextPath() %>/Student/studentList.jsp">학생리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Student/studentAddrList.jsp">학생주소리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp">학생점수리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Student/studentAndScoreAboveAvgList.jsp">평균점수이상의 학생 리스트</a></li>
		</ul>
		<ul>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">선생님리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherAddrList.jsp">선생님주소리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">선생님점수리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherListAboveAvg.jsp">평균점수이상의 선생님 리스트</a></li>
		</ul>
	</body>
</html>