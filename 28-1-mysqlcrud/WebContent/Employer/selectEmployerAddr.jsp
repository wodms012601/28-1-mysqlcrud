<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int employerNo = Integer.parseInt(request.getParameter("no")); //직원리스트에서 받은 직원 번호데이터를 변수에 대입

	EmployerAddrDao employerAddrDao = new EmployerAddrDao();
	//직원 번호 데이터가 저장된 변수를 매개변수로 대입하고 직원주소 데이터들이 저장된 직원주소 객체의 주소값을 리턴받는다.
	EmployerAddr employerAddr = employerAddrDao.selectEmployerAddr(employerNo);
%>
<html>
	<head>
		<title>직원 개인 주소 검색</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>학생 개인 점수 검색</h1>
		</div>
		<div id="content">
			<table border="1">
				<tr>
					<th>주소번호</th>
					<th>직원번호</th>
					<th>직원주소</th>
				</tr>
				<tr>
					<td><%=employerAddr.getEmployerAddrNo() %></td>
					<td><%=employerAddr.getEmployerNo() %></td>
					<td><%=employerAddr.getEmployerAddrContent() %></td>
				</tr>
			</table>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>