<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	int employerNo = Integer.parseInt(request.getParameter("no")); //리스트 페이지에서 넘겨받은 직원 번호 데이터를 변수에 저장
	
	EmployerScoreDao employerScore = new EmployerScoreDao();
	EmployerScore empScore = employerScore.selectEmployerScore(employerNo); //직원 번호 데이터를 매개변수로 직원점수 검색 메서드를 호출, 직원점수가 저장된 직원 객체의 주소값을 리턴받는다.
%>
<html>
	<head>
		<title>직원 점수 수정 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>직원 점수 수정 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Employer/updateEmployerScoreAction.jsp" method="post">
				<fieldset><!-- 직원 점수 -->
					<legend>점수입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 점수 :&nbsp;</div>
						<div><!-- 직원점수 -->
							<input type="text" name="employerScore" value="<%=empScore.getScore() %>" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required>
							<!-- onkeydown = 키를 눌렀을 때 발생하는 이벤트 / onkeyup = 눌렀던 키를 때면 발생하는 이벤트 -->
							<!-- onkeydown="return showKeyCode(event)" 과 같이 하면 showKeyDown 함수를 호출해서 결과가 true이면 본래의 동작을 그대로 수행하고 false이면 본래의 동작을 중단시킨다 -->
						</div>
						<input type="hidden" name="employerNo" value="<%=employerNo %>"> <!-- 직원 번호 데이터 -->
				</fieldset><br>
				<fieldset>
					<input type="submit" value="점수수정">
				</fieldset>
			</form>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>