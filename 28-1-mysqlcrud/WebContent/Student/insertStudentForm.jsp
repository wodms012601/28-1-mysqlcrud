<!-- 탁재은, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>학생 정보 입력 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>학생 정보 입력 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Student/insertStudentAction.jsp" method="post">
				<fieldset>
					<legend>개인 정보</legend>
					<table>
						<tr><!-- 이름 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>이름 :&nbsp;</td>
							<td>
								<input type="text" name="studentName" id="name" onkeyup="nameCheck()" >
								<span id="nameCheck"></span>
							</td>
						</tr>
						<tr><!-- 나이 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>나이 :&nbsp;</td>
							<td>
								<input type="text" name="studentAge" id="age" onkeyup="ageCheck()" >
								<span id="ageCheck"></span>
							</td>
						</tr>
						<tr><!-- 주소 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>주소 :&nbsp;</td>
							<td>
								<input type="text" name="studentAddrContent" size="40" id="addr" onkeyup="addrCheck()" >
								<span id="addrCheck"></span>
							</td>
						</tr>
					</table>
				</fieldset><br>
				<fieldset>
					<input type="submit" value="가입">
				</fieldset>
			</form>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>