<!-- 28th Choi Yun-Seok, 2018.07.9 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
	<%		
		request.setCharacterEncoding("UTF-8");

		TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
		ArrayList<TeacherAndScore> arrayList = teacherScoreDao.selectTeacherAndScored();	
	%>
			<table border="1">
				<tr>
					<th>teacher_no</th>
					<th>teacher_name</th>
					<th>teacher_age</th>
					<th>score</th>
				</tr>
				<%
					for(int i=0; i<arrayList.size(); i++){			
				%>
						<tr>
							<td><%=arrayList.get(i).getTeacherScore().getTeacherNo()%></td>
							<td><%=arrayList.get(i).getTeacher().getTeacherName()%></td>
							<td><%=arrayList.get(i).getTeacher().getTeacherAge()%></td>
							<td><%=arrayList.get(i).getTeacherScore().getScore()%></td>
						</tr>
				<%
					}
				%>
			</table>
			<a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">돌아가기</a>
	</body>
</html>