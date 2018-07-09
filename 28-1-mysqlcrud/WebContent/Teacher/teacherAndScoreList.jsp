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
		int send_id = Integer.parseInt(request.getParameter("send_id"));
		
		TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
		ArrayList<TeacherAndScore> arrayList = teacherScoreDao.selectTeacherAndScored(send_id);	
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
						TeacherAndScore teacherAndScore = arrayList.get(i);
						Teacher teacher = teacherAndScore.getTeacher();
						TeacherScore teacherScore = teacherAndScore.getTeacherScore();				
				%>
						<tr>
							<td><%=teacherScore.getTeacherNo()%></td>
							<td><%=teacher.getTeacherName()%></td>
							<td><%=teacher.getTeacherAge()%></td>
							<td><%=teacherScore.getScore()%></td>
						</tr>
				<%
					}
				%>
			</table>
	</body>
</html>