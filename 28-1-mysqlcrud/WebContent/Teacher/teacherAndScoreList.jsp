<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teacher And Score List</title>
<style>
body {
width:800px;
margin:0 auto;
}

#header {
margin:0 0 10px 0;
padding:10px;
border:1px solid #000;
background-color:#DAD9FF;
width:800px;
}

#content {
float:left;
padding:10px;
background-color:#D4F4FA;
border:1px solid #000;
width:800px;
margin-bottom:10px;
}

#sidebar_a {
float:left;
padding:10px;
border:1px solid #000;
width:800px;
background-color:#D9E5FF;
}

#footer {
clear:both;
padding:10px;
border:1px solid #000;
background-color:#E8D9FF;
width:800px;
}
</style>
</head>
<body>
	 <div id="header">
		<h1>Teacher And Score List</h1>
	</div>
	
	<div id="sidebar_a">
		<ul>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">선생님 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherAddrList.jsp">주소 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">점수 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherListAboveAvg.jsp">평균점수 이상 리스트</a></li>
		</ul>
	</div>

<%
	request.setCharacterEncoding("UTF-8");

	int currentPage = 1; // 현재 페이지
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage")); // 인트 변환
	}

	int pagePerRow = 10; // 한 페이지당 보이는 수
	int beginRow = (currentPage-1)*pagePerRow;

	TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
	int totalRowCount = teacherScoreDao.selectTotalTeacherCountJoin2();
	ArrayList<TeacherAndScore> arrayList = teacherScoreDao.selectTeacherAndScored(beginRow, pagePerRow);	
%>
		
	<div id="content">
		<div>전체행의 수 : <%=totalRowCount%> / 현재행의 수: <%=arrayList.size()%></div>
			<table border="1">
				<thead>
					<tr>
						<th>teacher_no</th>
						<th>teacher_name</th>
						<th>teacher_age</th>
						<th>score</th>
					</tr>
				</thead>
				<tbody>
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
            <a href="<%=request.getContextPath()%>/Teacher/teacherAndScoreList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%
        }
        if(currentPage<lastPage) {
%>
 
            <a href="<%=request.getContextPath()%>/Teacher/teacherAndScoreList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%
		}
%>
	</div>
		<br>
		<br>
		<br>
		<a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">돌아가기</a>
	</div>
	
	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
	</body>
</html>