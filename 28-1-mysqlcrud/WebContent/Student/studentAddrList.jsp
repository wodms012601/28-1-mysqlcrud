<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	StudentAddrDao studentAddrDao = new StudentAddrDao();
	//학생 주소를 검색하는 메서드를 호출하고 학생 주소데이터가 담긴 객체의 주소값을 담은 배열객체의 주소값을 리턴받는다.
	ArrayList<StudentAddr> studentAddrList = studentAddrDao.selectStudentAddrList(); 
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
		<%
			for(int i=0; i<studentAddrList.size(); i++){
		%>
			<tr>
				<td><%=studentAddrList.get(i).getStudentAddrNo() %></td>
				<td><%=studentAddrList.get(i).getStudentNo() %></td>
				<td><%=studentAddrList.get(i).getStudentAddrContent() %></td>
			</tr>
		<%	
			}
		%>
		</table><br>
		<div><a href="<%=request.getContextPath() %>/Student/studentList.jsp">학생 리스트 페이지로</a></div>
	</body>
</html>