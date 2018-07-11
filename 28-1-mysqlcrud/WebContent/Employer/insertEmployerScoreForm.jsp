<!-- 탁재은, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String employerNo = request.getParameter("no"); //리스트 페이지에서 넘겨받은 고용주 번호 데이터를 변수에 저장
%>
<html>
	<head>
		<title>고용주 점수 입력 폼</title>
	</head>
	<body>
		<!-- 데이터 전송 확인용 테스트 폼 -->
		<form action="<%= request.getContextPath()%>/Employer/insertEmployerScoreAction.jsp" method="post">
			<fieldset><!-- 학생 점수 -->
				<legend>점수입력</legend>
					<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 점수 :&nbsp;</div>
					<div><input type="text" name="employerScore"></div> <!-- 고용주점수 -->
					<input type="hidden" name="employerNo" value="<%=employerNo %>"> <!-- 고용주 번호 데이터 -->
			</fieldset><br>
			<fieldset>
				<input type="submit" value="점수입력">
			</fieldset>
		</form>
	</body>
</html>