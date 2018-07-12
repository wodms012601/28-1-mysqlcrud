<!-- join과 서브쿼리를 사용하여 평균 90이상인 학생들을 뽑아낸 화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			MemberScoreDao dao3 = new MemberScoreDao();
			
			ArrayList<MemberAndScore> result3= dao3.overSelectMemberList();
			int a = dao3.selectScoreAvg();
		%>
<html>
	<head>
		<title>회원점수 평균이상 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>회원점수 평균이상 리스트</h1>
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
			<table border="1">
				<thead>
					<tr>
						<th>회원번호</th>
						<th>회원이름</th>
						<th>회원점수</th>
					</tr>
				</thead>
				<tbody>
		<%	
			for(int i=0; i<result3.size(); i++) {
		%>
					전체평균 :<%=a %>
					<tr>
						<td><%=result3.get(i).getMember().getMember_no() %></td>
						<td><%=result3.get(i).getMember().getMember_name() %></td>
						<td><%=result3.get(i).getMemberScore().getScore() %></td>
					</tr>
				
		<%		
			}
		%>
				</tbody>
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