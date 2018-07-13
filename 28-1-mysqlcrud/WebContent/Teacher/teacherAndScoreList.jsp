<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teacher And Score List</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
	 <div id="header">
		<h1>Teacher And Score List</h1>
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
	request.setCharacterEncoding("UTF-8");
	
	// 페이징
	int currentPage = 1;
	int pagePerRow = 7;
	
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String scoreKeyword = ""; // 키워드 초기값

	// 검색 키워드 세션 검색 결과 페이지 유지
	if(request.getParameter("scoreKeyword") != null){

		scoreKeyword = request.getParameter("scoreKeyword");

		request.getSession().setAttribute("scoreKeyword", scoreKeyword);

	}else if(request.getSession().getAttribute("scoreKeyword") != null){ 

		scoreKeyword = (String)request.getSession().getAttribute("scoreKeyword");

	}

	TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
	ArrayList<TeacherAndScore> teacherScoreList = teacherScoreDao.teacherScoreJoin(currentPage, pagePerRow, scoreKeyword);
	
	int lastPage = teacherScoreDao.paging(pagePerRow, scoreKeyword); // 마지막 페이지 값 리턴

%>
		
	<div id="content">
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
					for(int i=0; i<teacherScoreList.size(); i++){		
%>
					<tr>
						<td><%=teacherScoreList.get(i).getTeacherScore().getTeacherNo()%></td>
						<td><%=teacherScoreList.get(i).getTeacher().getTeacherName()%></td>
						<td><%=teacherScoreList.get(i).getTeacher().getTeacherAge()%></td>
						<td><%=teacherScoreList.get(i).getTeacherScore().getScore()%></td>
					</tr>
<%
}
%>
				</tbody>
			</table>
	    <br>
	    <form action="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp" method="get">
	    		<input type = "text" name="scoreKeyword">
	    		<input type="submit" value = "점수검색">
	    	
	    </form>

	    <div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp?currentPage=<%=currentPage-1 %>&scoreKeyword=<%=scoreKeyword%>">이전</a>
			<%
				}
				for(int L=1; L<=lastPage; L++){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp?currentPage=<%=L%>&scoreKeyword=<%=scoreKeyword%>"><%=L%></a>
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp?currentPage=<%=currentPage+1 %>&scoreKeyword=<%=scoreKeyword%>">다음</a>
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