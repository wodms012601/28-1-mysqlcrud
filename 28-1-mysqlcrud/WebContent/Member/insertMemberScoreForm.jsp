<!-- 점수삽입화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String no = request.getParameter("no");
%>
<html>
	<head>
		<title>회원 점수 입력 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>회원 점수 입력 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Member/insertMemberScoreAction.jsp" method="post">
				<fieldset><!-- 학생 점수 -->
					<legend>점수입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 점수 :&nbsp;</div>
						<div><input type="text" name="score"></div> <!-- 회원점수 -->
						<input type="hidden" name="Member_no" value="<%=no %>"> <!-- 회원 번호 데이터 -->
				</fieldset><br>
				<fieldset>
					<input type="submit" value="점수입력">
				</fieldset>
			</form>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>