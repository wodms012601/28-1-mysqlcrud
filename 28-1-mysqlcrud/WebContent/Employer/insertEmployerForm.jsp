<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>insertEmployerForm</title>
	</head>
	<body>
		<!-- 데이터 전송 확인용 테스트 폼 -->
		<form action="<%= request.getContextPath()%>/insertStudentAction.jsp" method="post">
			<fieldset>
				<legend>개인 정보</legend>
				<table>
					<tr><!-- 이름 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>이름 :&nbsp;</td>
						<td>
							<input type="text" name="employerName">
						</td>
					</tr>
					<tr><!-- 나이 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>나이 :&nbsp;</td>
						<td colspan="3">
							<input type="text" name="employerAge" size="40">
						</td>
					</tr>
					<tr><!-- 주소 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>주소 :&nbsp;</td>
						<td colspan="3">
							<input type="text" name="addr" size="40">
						</td>
					</tr>
				</table>
			</fieldset><br>
			<fieldset>
				<input type="button" value="가입">
			</fieldset>
		</form>
	</body>
</html>