<!-- 2018-06-26 28기 송원민 모델1 insert 작업 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<title>회원 정보 입력 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>회원 정보 입력 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Member/insertMemberAction.jsp" method="post">
				<fieldset>
					<legend>개인 정보</legend>
					<table>
						<tr><!-- 이름 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>이름 :&nbsp;</td>
							<td>
								<input type="text" name="name" id="name" onkeyup="nameCheck()" >
								<span id="nameCheck"></span>
							</td>
						</tr>
						<tr><!-- 나이 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>나이 :&nbsp;</td>
							<td>
								<input type="text" name="age" id="age" onkeyup="ageCheck()" >
								<span id="ageCheck"></span>
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