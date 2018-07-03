<!-- 탁재은, 2018.07.03 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no"));

	StudentAddrDao studentAddrDao = new StudentAddrDao();
	StudentAddr studentAddr = studentAddrDao.selectStudentAddr(studentNo); //어느 학생을 보려고 했는지 알기위해 no값을 넘겨줌
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
				<th>수정</th><!-- 수정페이지로 -->
				<th>삭제</th><!-- 삭제하고 바로 리스트로 이동 -->
			</tr>
			<tr>
				<td><%=studentAddr.getStudentAddrNo() %></td>
				<td><%=studentAddr.getStudentNo() %></td> <!-- 주소링크 -->
				<td><%=studentAddr.getStudentAddrContent() %></td>
			</tr>
		</table>
		<form>
			<!-- 검색 -->
		</form>
	</body>
</html>