<!-- 전체점수리스트 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");	

	int pagePerRow = 4; //한화면당 나오는 행의 갯수
	int currentPage = 1; //첫페이지
	if(request.getParameter("currentPage") != null){ 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	//검색 작업
	String scoreKeyword = ""; //검색 초기값 공백
	if(request.getParameter("scoreKeyword") != null){
		scoreKeyword = request.getParameter("scoreKeyword"); //검색값이 들어오면 변수에 저장
	
		request.getSession().setAttribute("scoreKeyword", scoreKeyword);
	} else if(request.getSession().getAttribute("scoreKeyword") != null){ 

		scoreKeyword = (String)request.getSession().getAttribute("scoreKeyword");
	}

	MemberScoreDao dao5 = new MemberScoreDao();
	ArrayList<MemberAndScore> result4 = dao5.allSelectMemberAndScore(currentPage, pagePerRow, scoreKeyword);
	
	int lastPage = dao5.paging(pagePerRow, scoreKeyword);
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
				<li><a href="<%=request.getContextPath() %>/Member/memberList.jsp">회원 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAddrList.jsp">회원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAndScoreList.jsp">회원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAndScoreAboveAvgList.jsp">평균점수이상의 회원 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<form action="<%=request.getContextPath() %>/Member/memberAndScoreList.jsp" method="post">
				<div>검색 : &nbsp;<input type="text" name="scoreKeyword"> &nbsp; <input type="submit" value="검색"></div> <!-- 검색입력폼 -->
			</form><br>
			<table border="1">
				<tr>
					<th>회원번호</th>
					<th>회원이름</th>
					<th>회원나이</th>
					<th>회원점수</th>
				</tr>		
		<%	
			for(int i=0; i<result4.size(); i++) {
		%>		
				<tr>
					<td><%=result4.get(i).getMember().getMember_no() %></td>
					<td><%=result4.get(i).getMember().getMember_name() %></td>
					<td><%=result4.get(i).getMember().getMember_age() %></td>
					<td><%=result4.get(i).getMemberScore().getScore() %></td>
				</tr>
		<%
			}
		%>
		</table>
		
		<div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Member/memberAndScoreList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
			<%
				}
				for(int j=1; j<=lastPage; j++){
			%>
				<a href="<%=request.getContextPath() %>/Member/memberAndScoreList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Member/memberAndScoreList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
			<%	
				}
			%>
		</div><br>
		
		<div><a href="<%=request.getContextPath() %>/Member/insertMemberForm.jsp">학생 정보 입력 페이지</a></div>
		</div>
		
		<div id="footer">
				COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>