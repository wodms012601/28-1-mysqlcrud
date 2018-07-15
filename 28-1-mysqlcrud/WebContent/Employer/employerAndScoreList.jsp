<!-- 탁재은, 2018.07.12 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	//페이징 작업
	int pagePerRow = 7; //한 페이지당 보는 갯수
	int currentPage = 1; //현재 페이지
	if(request.getParameter("currentPage") != null){ //페이지 이동 후 currentPage가 String타입이 되기때문에 int 데이터타입으로 변경
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
	
	EmployerScoreDao employerScore = new EmployerScoreDao();
	//직원 테이블과 직원점수 테이블을 조인하는 메서드를 호출하고 직원 객체와 직원점수 객체의 주소값이 저장된 조인객체의 주소값을 담은 배열객체를 리턴받는다.
	ArrayList<EmployerAndScore> employerJoin = employerScore.employerScoreJoin(currentPage, pagePerRow, scoreKeyword);
	
	int lastPage = employerScore.paging(pagePerRow, scoreKeyword); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>직원점수 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>직원점수 리스트</h1>
		</div>
		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Employer/employerList.jsp">직원 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Employer/employerAddrList.jsp">직원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Employer/employerAndScoreList.jsp">직원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Employer/employerAndScoreAboveAvgList.jsp">평균점수 이상 직원 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<table border="1">
				<thead>
					<tr>
						<th>직원번호</th>
						<th>직원이름</th>
						<th>직원나이</th>
						<th>직원점수</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(int i=0; i<employerJoin.size(); i++){
				%>
					<tr>
						<td><%=employerJoin.get(i).getEmployer().getEmployerNo() %></td> <!-- 고용주 번호 -->
						<td><%=employerJoin.get(i).getEmployer().getEmployerName() %></td> <!-- 고용주 이름 -->
						<td><%=employerJoin.get(i).getEmployer().getEmployerAge() %></td> <!-- 고용주 나이 -->
						<td><%=employerJoin.get(i).getEmployerScore().getScore() %></td> <!-- 고용주 점수 -->
					</tr>
				<%
					}
				%>
				</tbody>
			</table><br>
			<form action="<%=request.getContextPath() %>/Employer/employerAndScoreList.jsp" method="post">
				<div><input type="text" name="scoreKeyword"> &nbsp; <input type="submit" value="점수검색"></div> <!-- 검색입력폼 -->
			</form>
			<div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Employer/employerAndScoreList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
			<%
				}
				for(int j=1; j<=lastPage; j++){
			%>
				<a href="<%=request.getContextPath() %>/Employer/employerAndScoreList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Employer/employerAndScoreList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
			<%	
				}
			%>
			</div><br>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>