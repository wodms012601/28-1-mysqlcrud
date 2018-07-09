<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String studentNo = request.getParameter("no"); //리스트 페이지에서 넘겨받은 학생 번호 데이터를 변수에 저장
%>
<html>
	<head>
		<title>insertStudentScoreForm</title>
	</head>
	<body>
		<!-- 데이터 전송 확인용 테스트 폼 -->
		<form action="<%= request.getContextPath()%>/Student/insertStudentScoreAction.jsp" method="post">
			<fieldset><!-- 학생 점수 -->
				<legend>점수입력</legend>
					<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 점수 :&nbsp;</div>
					<div><input type="text" name="studentScore"></div> <!-- 학생점수 -->
					<input type="hidden" name="studentNo" value="<%=studentNo %>"> <!-- 학생 번호 데이터 -->
			</fieldset><br>
			<fieldset>
				<input type="submit" value="점수입력">
			</fieldset>
		</form>
	</body>
</html>