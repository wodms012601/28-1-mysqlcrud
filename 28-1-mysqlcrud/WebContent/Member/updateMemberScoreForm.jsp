<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String no = request.getParameter("no");
	String name = request.getParameter("name");
	MemberScoreDao dao = new MemberScoreDao();
	MemberScore result = dao.selectUpdateScore(Integer.parseInt(no));
	int score = result.getScore();
%>
<html>
	<head>
		<title>회원 점수 수정 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>회원 점수 수정 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Member/updateMemberScoreAction.jsp" method="post">
				<fieldset><!-- 학생 점수 -->
					<legend>점수수정</legend>
						<%=name %>님 현재점수 : <%=score %>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 점수 :&nbsp;</div>
						<div>
						<input type="text" name="score" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required>
							<!-- onkeydown = 키를 눌렀을 때 발생하는 이벤트 / onkeyup = 눌렀던 키를 때면 발생하는 이벤트 -->
							<!-- onkeydown="return showKeyCode(event)" 과 같이 하면 showKeyDown 함수를 호출해서 결과가 true이면 본래의 동작을 그대로 수행하고 false이면 본래의 동작을 중단시킨다 -->
						</div> <!-- 회원점수 -->
						<input type="hidden" name="Member_no" value="<%=no %>"> <!-- 회원 번호 데이터 -->
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