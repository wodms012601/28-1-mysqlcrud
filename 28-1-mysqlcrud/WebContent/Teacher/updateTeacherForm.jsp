<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Update Teacher Form</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
	<div id="header">
		<h1>Update Teacher Form</h1>
	</div>
	
<%
	String send_id = request.getParameter("send_id");
	System.out.println(send_id);
	TeacherDao teacherdao = new TeacherDao();
	Teacher t = teacherdao.selectTeacher(send_id);
%>

	<div id="content">
		<form action="<%=request.getContextPath()%>/Teacher/updateTeacherAction.jsp" method="post" >
				<fieldset>
					<legend>개인 정보</legend>
					<table>
						<tr><!-- 이름 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>이름 :&nbsp;</td>
							<td>
								<input type="hidden" name="teacher_no" value=<%=send_id%> readonly="readonly" >
								<input type="text" name="teacher_name" value=<%=t.getTeacherName()%> required><br/>
							</td>
						</tr>
						<tr><!-- 나이 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>나이 :&nbsp;</td>
							<td>
								<input type="text" name="teacher_age" value=<%=t.getTeacherAge()%> onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required>
							</td>
						</tr>
					</table>
				</fieldset><br>
				<fieldset>
					<input type="submit" value="수정">
				</fieldset>
			</form>
		</div>

		<div id="footer">
			COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>