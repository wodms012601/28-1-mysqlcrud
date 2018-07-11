<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int pagePerRow = 5; //한 페이지당 보는 갯수
	int currentPage = 1; //현재 페이지
	if(request.getParameter("currentPage") != null){ //페이지 이동 후 currentPage가 String타입이 되기때문에 int 데이터타입으로 변경
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//검색 작업
	String word = ""; //검색 초기값 공백
	if(request.getParameter("word") != null){
		word = request.getParameter("word"); //검색값이 들어오면 변수에 저장
	}
	
	EmployerDao dao = new EmployerDao();
	ArrayList<Employer> empList = dao.selectEmployerByPage(currentPage, pagePerRow, word);
	
	int lastPage = dao.paging(pagePerRow); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>고용주 리스트</title>
	</head>
	<body>
		<form action="<%=request.getContextPath() %>/Employer/employerList.jsp" method="post">
			<div><input type="text" name="word"></div> <!-- 검색입력폼 -->
			<input type="submit" value="검색">
		</form><br>
		<table border="1">
			<tr>
				<th>고용주번호</th>
				<th>고용주이름</th>
				<th>고용주나이</th>
				<th>수정</th>
				<th>삭제</th>
				<th>점수입력</th>
			</tr>
		<%
			for(int i=0; i<empList.size(); i++){
		%>
			<tr>
				<td><%=empList.get(i).getEmployerNo() %></td>
				<td><a href="<%=request.getContextPath() %>/Employer/selectEmployerAddr.jsp?no=<%=empList.get(i).getEmployerNo() %>"><%=empList.get(i).getEmployerName() %></a></td>
				<td><%=empList.get(i).getEmployerAge() %></td>
				<td><a href="<%=request.getContextPath() %>/Employer/updateEmployerForm.jsp?no=<%=empList.get(i).getEmployerNo() %>">수정</a></td>
				<td><a href="<%=request.getContextPath() %>/Employer/deleteEmployer.jsp?no=<%=empList.get(i).getEmployerNo() %>">삭제</a></td>
				<td><a href="<%=request.getContextPath() %>/Employer/insertEmployerScoreForm.jsp?no=<%=empList.get(i).getEmployerNo() %>">점수입력</a></td>
			</tr>
		<%
			}
		%>
		</table>
		<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath() %>/Employer/employerList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
		<%
			}
			for(int j=1; j<=lastPage; j++){
		%>
			<a href="<%=request.getContextPath() %>/Employer/employerList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
		<%
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath() %>/Employer/employerList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
		<%	
			}
		%>
		<br>
		<div><a href="<%=request.getContextPath() %>/index.jsp">메인 페이지로</a></div>
	</body>
</html>