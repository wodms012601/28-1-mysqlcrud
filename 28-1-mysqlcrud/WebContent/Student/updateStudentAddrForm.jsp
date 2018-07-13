<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no")); //리스트 페이지에서 넘겨받은 학생 번호 데이터를 변수에 저장
	
	StudentAddrDao studentAddr = new StudentAddrDao();
	StudentAddr stuAddr = studentAddr.selectStudentAddr(studentNo); //학생 번호 데이터를 매개변수로 학생점수 검색 메서드를 호출, 학생점수가 저장된 학생 객체의 주소값을 리턴받는다.
%>
<html>
	<head>
		<title>학생 주소 수정 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>학생 주소 수정 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Student/updateStudentAddrAction.jsp" method="post">
				<fieldset><!-- 학생 주소 -->
					<legend>주소입력</legend>
						<div><img src="<%=request.getContextPath() %>/image/check_icon.gif"> 주소 :&nbsp;</div>
						<div><!-- 학생주소 -->
							<input type="text" name="studentAddrContent" value="<%=stuAddr.getStudentAddrContent() %>" id="name" onkeyup="nameCheck()" required>
							<span id="nameSpan"></span>
						</div>
						<input type="hidden" name="studentNo" value="<%=studentNo %>"> <!-- 학생 번호 데이터 -->
				</fieldset><br>
				<fieldset>
					<input type="submit" value="주소수정">
				</fieldset>
			</form>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>