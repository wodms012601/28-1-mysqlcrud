<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	//페이징 작업
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
	
	EmployerAddrDao employerAddrDao = new EmployerAddrDao();
	//고용주 주소를 검색하는 메서드를 호출하고 고용주 주소데이터가 담긴 객체의 주소값을 담은 배열객체의 주소값을 리턴받는다.
	ArrayList<EmployerAddr> employerAddrList = employerAddrDao.selectEmployerAddrList(currentPage, pagePerRow, word);
	
	int lastPage = employerAddrDao.paging(pagePerRow); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>고용주주소 리스트</title>
	</head>
	<body>
		<form action="<%=request.getContextPath() %>/Employer/employerAddrList.jsp" method="post">
			<div><input type="text" name="word"></div> <!-- 검색입력폼 -->
			<input type="submit" value="검색">
		</form><br>
		<table border="1">
			<tr>
				<th>주소번호</th>
				<th>학생주소번호</th>
				<th>학생주소</th>
			</tr>
		<%
			for(int i=0; i<employerAddrList.size(); i++){
		%>
			<tr>
				<td><%=employerAddrList.get(i).getEmployerAddrNo() %></td>
				<td><%=employerAddrList.get(i).getEmployerNo() %></td>
				<td><%=employerAddrList.get(i).getEmployerAddrContent() %></td>
			</tr>
		<%	
			}
		%>
		</table>
		<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath() %>/Employer/employerAddrList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
		<%
			}
			for(int j=1; j<=lastPage; j++){
		%>
			<a href="<%=request.getContextPath() %>/Employer/employerAddrList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
		<%
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath() %>/Employer/employerAddrList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
		<%	
			}
		%>
		<br>
		<div><a href="<%=request.getContextPath() %>/index.jsp">메인 페이지로</a></div>
	</body>
</html>