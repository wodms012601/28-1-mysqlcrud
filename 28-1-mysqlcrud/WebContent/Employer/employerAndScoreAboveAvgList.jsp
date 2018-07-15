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
	
	EmployerScoreDao dao = new EmployerScoreDao();
	int avg = dao.selectScoreAvg(); //직원점수 테이블의 평균점수를 구하는 메서드를 호출하고 검색된 평균점수값을 리턴값으로 받는다.
	//평균점수보다 높은 직원을 검색하는 메서드를 호출하고 검색한 데이터가 담긴 객체들의 주소값이 저장된 배열객체의 주소값을 리턴받는다.
	ArrayList<EmployerAndScore> employerAvg = dao.selectEmployerListAboveAvg(currentPage, pagePerRow);
	
	int lastPage = dao.paging(pagePerRow); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>평균점수 이상의 직원 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>평균점수 이상의 직원 리스트</h1>
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
			<div><h3>평균 점수 : <%=avg %>점</h3></div>
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
					for(int i=0; i<employerAvg.size(); i++){
				%>
					<tr>
						<td><%=employerAvg.get(i).getEmployer().getEmployerNo() %></td>
						<td><%=employerAvg.get(i).getEmployer().getEmployerName() %></td>
						<td><%=employerAvg.get(i).getEmployer().getEmployerAge() %></td>
						<td><%=employerAvg.get(i).getEmployerScore().getScore() %></td>
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
				<a href="<%=request.getContextPath() %>/Employer/employerAndScoreAboveAvgList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
			<%
				}
				for(int j=1; j<=lastPage; j++){
			%>
				<a href="<%=request.getContextPath() %>/Employer/employerAndScoreAboveAvgList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Employer/employerAndScoreAboveAvgList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
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