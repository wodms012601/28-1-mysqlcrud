<!-- 07.10 송원민 : 회원주소삽입 화면 작업 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>회원 주소 입력창</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
 		<div id="header">
			<h1>회원 주소 입력창</h1>
		</div>
	<%
		String no = request.getParameter("no"); // memberList회원번호 
	%>
	
		<div id="content">	
			<form action = "<%= request.getContextPath() %>/Member/insertMemberAddrAction.jsp?" method="post">
							<fieldset><!-- 학생 점수 -->
					<legend>주소입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 주소 :&nbsp;</div>
						<div><!-- 학생점수 -->
							<input type="text" name="Member_addr_content" id="name" onkeyup="nameCheck()" required>
							<input type="hidden" name="Member_no" value="<%=no %>"> <!-- 회원 번호 데이터 -->
						</div>
				</fieldset><br>
				<fieldset>
					<input type="submit" value="주소입력">
				</fieldset>
			</form>
		</div>

		<div id="footer">
			COPYRIGHT(C) 1조 프로젝트  All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>
					