<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no")); //학생 리스트에서 받은 학생 번호데이터를 변수에 대입

	StudentAddrDao studentAddrDao = new StudentAddrDao();
	//학생 번호 데이터가 저장된 변수를 매개변수로 대입하고 학생주소 데이터들이 저장된 학생주소 객체의 주소값을 리턴받는다.
	StudentAddr studentAddr = studentAddrDao.selectStudentAddr(studentNo); 
%>
<html>
	<head>
		<title>studentAddrList</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>주소번호</th>
				<th>학생주소번호</th>
				<th>학생주소</th>
			</tr>
			<tr>
				<td><%=studentAddr.getStudentAddrNo() %></td>
				<td><%=studentAddr.getStudentNo() %></td>
				<td><%=studentAddr.getStudentAddrContent() %></td>
			</tr>
		</table>
		<form>
			<!-- 검색 -->
		</form>
	</body>
</html>