<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String studentNo = request.getParameter("no");
%>
<html>
	<head>
		<title>학생 주소 입력 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>학생 주소 입력 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Student/insertStudentAddrAction.jsp" method="post">
				<fieldset><!-- 학생 점수 -->
					<legend>주소입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 주소 :&nbsp;</div>
						<div><!-- 학생점수 -->
							<input type="text" name="studentAddrContent" id="name" onkeyup="nameCheck()" required>
							<span id="nameSpan"></span>
						</div>
						<input type="hidden" name="studentNo" value="<%=studentNo %>"> <!-- 학생 번호 데이터 -->
				</fieldset><br>
				<fieldset>
					<input type="submit" value="주소입력">
				</fieldset>
			</form>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>