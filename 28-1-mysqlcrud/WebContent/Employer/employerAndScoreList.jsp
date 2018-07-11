<!-- 탁재은, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	//페이징 작업
	int pagePerRow = 5; //한 페이지당 보는 갯수
	int currentPage = 1; //현재 페이지
	if(request.getParameter("currentPage") != null){ //페이지 이동 후 currentPage가 String타입이 되기때문에 int 데이터타입으로 변경
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	EmployerScoreDao employerScore = new EmployerScoreDao();
	//고용주 테이블과 점수 테이블을 조인하는 메서드를 호출하고 고용주 객체와 고용주점수 객체의 주소값이 저장된 조인객체의 주소값을 담은 배열객체를 리턴받는다.
	ArrayList<EmployerAndScore> employerJoin = employerScore.employerScoreJoin(currentPage, pagePerRow);
	
	int lastPage = employerScore.paging(pagePerRow); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>고용주점수 리스트</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>고용주번호</th>
				<th>고용주이름</th>
				<th>고용주나이</th>
				<th>고용주점수</th>
			</tr>
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
		</table>
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
		<br>
		<div><a href="<%=request.getContextPath() %>/index.jsp">메인 페이지로</a></div>
	</body>
</html>