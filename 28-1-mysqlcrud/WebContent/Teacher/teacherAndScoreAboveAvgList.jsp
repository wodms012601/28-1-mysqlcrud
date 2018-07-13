<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teacher And Score Above Avg List</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
	<div id="header">
		<h1>Teacher And Score Above Avg List</h1>
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
	int currentPage = 1; // 현재 페이지
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage")); // 인트 변환
	}	
	int pagePerRow = 7; // 한 페이지당 보이는 수
	int beginRow = (currentPage-1)*pagePerRow;
	
	TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
	int scoreAvg = teacherScoreDao.selectScoreAvg();
	int totalRowCount = teacherScoreDao.selectTotalTeacherCountJoin(); // 전체 행의 수
	
	ArrayList<TeacherAndScore> list = teacherScoreDao.selectTeacherListAboveAVG(beginRow, pagePerRow);
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
					for(int i=0; i<list.size(); i++) {
%>
					<tr>
						<td><%=list.get(i).getTeacher().getTeacher_no()%></td>
						<td><%=list.get(i).getTeacher().getTeacherName()%></td>
						<td><%=list.get(i).getTeacher().getTeacherAge()%></td>
						<td><%=list.get(i).getTeacherScore().getScore()%></td>
					</tr>
<%
					}
%>
					</tbody>
				</table>
<%
    int lastPage = totalRowCount/pagePerRow; // 마지막 페이지
    if(totalRowCount%pagePerRow != 0) {
        lastPage++;
    }
%>
    <div>
<%
        if(currentPage>1) {
%>
            <a href="<%=request.getContextPath()%>/Teacher/teacherAndScoreAboveAvgList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%
        }
        if(currentPage<lastPage) {
%>
 
            <a href="<%=request.getContextPath()%>/Teacher/teacherAndScoreAboveAvgList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%
        }
%>
	</div>
		<br>
		<br>
		<br>
		<a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp">돌아가기</a>
	</div>
	
	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
</body>
</html>