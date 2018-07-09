<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	StudentScoreDao studentScore = new StudentScoreDao();
	//학생 테이블과 점수 테이블을 조인하는 메서드를 호출하고 학생 객체와 학생점수 객체의 주소값이 저장된 조인객체의 주소값을 담은 배열객체를 리턴받는다.
	ArrayList<StudentAndScore> studentJoin = studentScore.studentScoreJoin();
%>
<html>
	<head>
		<title>studentAndScoreList</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>학생번호</th>
				<th>학생이름</th>
				<th>학생나이</th>
				<th>학생점수</th>
			</tr>
		<%
			for(int i=0; i<studentJoin.size(); i++){
		%>
			<tr>
				<td><%=studentJoin.get(i).getStudent().getStudentNo() %></td> <!-- 학생 번호 -->
				<td><%=studentJoin.get(i).getStudent().getStudentName() %></td> <!-- 학생 이름 -->
				<td><%=studentJoin.get(i).getStudent().getStudentAge() %></td> <!-- 학생 나이 -->
				<td><%=studentJoin.get(i).getStudentScore().getScore() %></td> <!-- 학생 점수 -->
			</tr>
		<%
			}
		%>
		</table>
		<div><a href="<%=request.getContextPath() %>/Student/studentList.jsp">학생 리스트 페이지로</a></div>
	</body>
</html>