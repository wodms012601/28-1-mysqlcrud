<!-- 탁재은, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int employerNo = Integer.parseInt(request.getParameter("no")); //고용주리스트에서 받은 고용주 번호데이터를 변수에 대입

	EmployerAddrDao employerAddrDao = new EmployerAddrDao();
	//고용주 번호 데이터가 저장된 변수를 매개변수로 대입하고 고용주주소 데이터들이 저장된 고용주주소 객체의 주소값을 리턴받는다.
	EmployerAddr employerAddr = employerAddrDao.selectEmployerAddr(employerNo);
%>
<html>
	<head>
		<title>고용주 개인 주소 검색</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>주소번호</th>
				<th>고용주번호</th>
				<th>고용주주소</th>
			</tr>
			<tr>
				<td><%=employerAddr.getEmployerAddrNo() %></td>
				<td><%=employerAddr.getEmployerNo() %></td>
				<td><%=employerAddr.getEmployerAddrContent() %></td>
			</tr>
		</table>
	</body>
</html>