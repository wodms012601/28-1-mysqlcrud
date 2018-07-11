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
	
	EmployerScoreDao dao = new EmployerScoreDao();
	int avg = dao.selectScoreAvg(); //평균점수를 구하는 메서드를 호출하고 검색된 평균점수값을 리턴값으로 받는다.
	//평균점수보다 높은 학생을 검색하는 메서드를 호출하고 검색한 데이터가 담긴 객체들의 주소값이 저장된 배열객체의 주소값을 리턴받는다.
	ArrayList<EmployerAndScore> employerAvg = dao.selectEmployerListAboveAvg(currentPage, pagePerRow);
	
	int lastPage = dao.paging(pagePerRow); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>평균점수 이상의 고용주 리스트</title>
	</head>
	<body>
		<div>평균 점수 : <%=avg %></div>
		<table border="1">
			<tr>
				<th>고용주번호</th>
				<th>고용주이름</th>
				<th>고용주점수</th>
			</tr>
		<%
			for(int i=0; i<employerAvg.size(); i++){
		%>
			<tr>
				<td><%=employerAvg.get(i).getEmployer().getEmployerNo() %></td>
				<td><%=employerAvg.get(i).getEmployer().getEmployerName() %></td>
				<td><%=employerAvg.get(i).getEmployerScore().getScore() %></td>
			</tr>
		<%
			}
		%>
		</table>
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
		<br>
		<div><a href="<%=request.getContextPath() %>/index.jsp">메인 페이지로</a></div>
	</body>
</html>