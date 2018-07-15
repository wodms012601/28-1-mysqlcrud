<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int employerNo = Integer.parseInt(request.getParameter("no")); //리스트 페이지에서 넘겨받은 직원 번호 데이터를 변수에 저장
	EmployerDao employerDao = new EmployerDao();
	Employer employer = employerDao.selectEmployer(employerNo); //직원 번호 데이터를 매개변수로 직원 리스트 검색 메서드를 호출, 직원이름과 직원나이가 저장된 직원 객체의 주소값을 리턴받는다.
	
	EmployerAddrDao employerAddrDao = new EmployerAddrDao();
	//직원 번호 데이터를 매개변수로 직원주소 리스트 검색 메서드를 호출, 직원 주소가 저장된 직원주소 객체의 주소값을 리턴받는다.
	EmployerAddr employerAddr = employerAddrDao.selectEmployerAddr(employerNo);
%>
<html>
	<head>
		<title>직원 정보 수정 페이지</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>직원 정보 수정 페이지</h1>
		</div>
		<div id="content">
			<!-- 데이터 전송 확인용 테스트 폼 -->
			<form action="<%= request.getContextPath()%>/Employer/updateEmployerAction.jsp?no=<%=employerNo %>" method="post">
				<fieldset>
					<legend>개인 정보</legend>
					<table>
						<tr><!-- 이름 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>이름 :&nbsp;</td>
							<td>
								<input type="text" name="employerName" value="<%=employer.getEmployerName() %>" id="name" onkeyup="nameCheck()" required>
								<span id="nameSpan"></span>
							</td>
						</tr>
						<tr><!-- 나이 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>나이 :&nbsp;</td>
							<td>
								<input type="text" name="employerAge" size="40" value="<%=employer.getEmployerAge() %>" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required>
								<!-- onkeydown = 키를 눌렀을 때 발생하는 이벤트 / onkeyup = 눌렀던 키를 때면 발생하는 이벤트 -->
								<!-- onkeydown="return showKeyCode(event)" 과 같이 하면 showKeyDown 함수를 호출해서 결과가 true이면 본래의 동작을 그대로 수행하고 false이면 본래의 동작을 중단시킨다 -->
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
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>