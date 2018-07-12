<!-- 전체점수리스트 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
		<%
			MemberScoreDao dao5 = new MemberScoreDao();
			ArrayList<MemberAndScore> result4 = dao5.AllSelectMemberAndScore();
		%>			
<html>
	<head>
		<title>전체회원 점수 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>전체회원 점수 리스트</h1>
		</div>
		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/allMemberAddrList.jsp">회원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/allMemberAndScoreList.jsp">회원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/overMemberScoreList.jsp">평균점수이상의 회원 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<form action="<%=request.getContextPath() %>/Student/studentList.jsp" method="post">
				<div>검색 : &nbsp;<input type="text" name="word"> &nbsp; <input type="submit" value="검색"></div> <!-- 검색입력폼 -->
			</form><br>
			<table border="1">
				<tr>
					<th>회원번호</th>
					<th>회원이름</th>
					<th>회원점수</th>
				</tr>		
		<%	
			for(int i=0; i<result4.size(); i++) {
		%>		
				<tr>
					<td><%=result4.get(i).getMember().getMember_no() %></td>
					<td><%=result4.get(i).getMember().getMember_name() %></td>
					<td><%=result4.get(i).getMemberScore().getScore() %></td>
				</tr>
		<%
			}
		%>
		</table>
		
		<div>
		</div><br>
		
		<div><a href="<%=request.getContextPath() %>/Member/insertMemberForm.jsp">학생 정보 입력 페이지</a></div>
		</div>
		
		<div id="footer">
				COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>