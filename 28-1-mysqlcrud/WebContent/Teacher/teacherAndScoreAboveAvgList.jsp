<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>평균점수가 넘는 선생님 리스트</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
	<div id="header">
		<h1>평균점수가 넘는 선생님 리스트</h1>
	</div>
	
	<div id="sidebar_a">
		<ul>
			<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp">선생님 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAddrList.jsp">주소 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">점수 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreAboveAvgList.jsp">평균점수 이상 리스트</a></li>
		</ul>
	</div>
<%
	int currentPage = 1;
	int pagePerRow = 7;
	
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
	int scoreAvg = teacherScoreDao.selectScoreAvg();
	
	ArrayList<TeacherAndScore> teacherAndScoreList = teacherScoreDao.selectTeacherListAboveAvg(currentPage, pagePerRow);
	
	int lastPage = teacherScoreDao.paging(pagePerRow);
%>
	<div id="content">
			<div>
				평균 : <%=scoreAvg%>
			</div>
				<table border="1">
					<thead>
						<tr>
							<th>선생님번호</th>
							<th>선생님이름</th>
							<th>선생님나이</th>
							<th>선생님점수</th>
						</tr>
					</thead>
					<tbody>
<%
					for(int i=0; i<teacherAndScoreList.size(); i++) {
%>
					<tr>
						<td><%=teacherAndScoreList.get(i).getTeacher().getTeacher_no()%></td>
						<td><%=teacherAndScoreList.get(i).getTeacher().getTeacherName()%></td>
						<td><%=teacherAndScoreList.get(i).getTeacher().getTeacherAge()%></td>
						<td><%=teacherAndScoreList.get(i).getTeacherScore().getScore()%></td>
					</tr>
<%
					}
%>
					</tbody>
				</table>
    <div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreAboveAvgList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
			<%
				}
				for(int L=1; L<=lastPage; L++){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreAboveAvgList.jsp?currentPage=<%=L%>"><%=L%></a>
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreAboveAvgList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
			<%	
				}
			%>
	</div>
	</div>
	
	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
</body>
</html>