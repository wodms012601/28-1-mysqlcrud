<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String employerNo = request.getParameter("no");
%>
<html>
	<head>
		<title>직원 주소 입력 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>직원 주소 입력 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Employer/insertEmployerAddrAction.jsp" method="post">
				<fieldset><!-- 직원 점수 -->
					<legend>주소입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 주소 :&nbsp;</div>
						<div><!-- 직원점수 -->
							<input type="text" name="employerAddrContent" id="name" onkeyup="nameCheck()" required>
							<span id="nameSpan"></span>
						</div>
						<input type="hidden" name="employerNo" value="<%=employerNo %>"> <!-- 직원 번호 데이터 -->
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