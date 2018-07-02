<!-- 2018.07.02 송원민 페이징 model1 작업 ArrayList 처리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.Memberdao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="service.Member" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	
	<body>
		<%
			int pagePerRow = 4;
			int currentPage = 1;
			if(request.getParameter("currentPage") != null){ // currentPage 값이 null이 아니라면
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			Memberdao dao = new Memberdao();
			ArrayList<Member> result = dao.selectMemberByPage(currentPage, pagePerRow);
			
			int lastPage = dao.paging(pagePerRow);
		%>
		
		<%
			request.setCharacterEncoding("EUC_KR");
			
			
			
			
			for(int i=0; i<result.size(); i++) {
		%>
			<table border="1">
				<tr>
					<td>번호</td>
					<td>이름</td>
					<td>나이</td>
				<tr>
				<tr>
					<td><%=result.get(i).getMember_no() %></td>
					<td><%=result.get(i).getMember_name() %></td>
					<td><%=result.get(i).getMember_age()%></td>
				</tr>
			</table>
		<%
			}
		%>	
		
	
		<%
		if(currentPage > 1) {
		
		%>
		<a href="./MemberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<% 
		}
		if(currentPage < lastPage){
		%>
		
		<a href="./MemberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
		}
		%>

	</body>
</html>