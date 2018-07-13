<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>선생님 정보 입력 페이지</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
 	<div id="header">
		<h1>선생님 정보 입력 페이지</h1>
	</div>

<%
	String send_id = request.getParameter("send_id");
%>
	<div id="content">	
			<form action="<%= request.getContextPath()%>/Teacher/insertTeacherAddrAction.jsp" method="post">
				<fieldset>
					<legend>주소입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 주소 :&nbsp;</div>
						<div>
							<input type = "text" name = "teacher_addr_content" required >
						</div>
							<input type = "hidden" name = "teacher_no" value=<%=send_id%> readonly="readonly">
				</fieldset><br>
				<fieldset>
					<input type = "submit" value = "주소입력">
				</fieldset>
			</form>
		</div>

		<div id="footer">
			COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
		</div>
	
</body>
</html>