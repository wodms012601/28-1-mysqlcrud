<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	StudentScoreDao dao = new StudentScoreDao();
	int avg = dao.selectScoreAvg(); //평균점수를 구하는 메서드를 호출하고 검색된 평균점수값을 리턴값으로 받는다.
	
	//평균점수보다 높은 학생을 검색하는 메서드를 호출하고 검색한 데이터가 담긴 객체들의 주소값이 저장된 배열객체의 주소값을 리턴받는다.
	ArrayList<StudentAndScore> studentAvg = dao.selectStudentListAboveAvg();
%>
<html>
	<head>
		<title>평균점수가 넘는 학생의 리스트</title>
	</head>
	<body>
		<div>평균 점수 : <%=avg %></div>
		<table border="1">
			<tr>
				<th>학생번호</th>
				<th>학생이름</th>
				<th>학생점수</th>
			</tr>
		<%
			for(int i=0; i<studentAvg.size(); i++){
		%>
			<tr>
				<td><%=studentAvg.get(i).getStudent().getStudentNo() %></td>
				<td><%=studentAvg.get(i).getStudent().getStudentName() %></td>
				<td><%=studentAvg.get(i).getStudentScore().getScore() %></td>
			</tr>
		<%
			}
		%>
		</table><br>
		<div><a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp">점수리스트</a></div>
	</body>
</html>