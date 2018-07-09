<!-- 2018.07.02 송원민 페이징 model1 작업 ArrayList 처리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.Memberdao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="service.Member" %>

<!DOCTYPE html>
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
					<th>번호</th>
					<th>이름</th>
					<th>나이</th>
					<th>주소입력</th><!-- 다수 -->
					<th>수정</th>
					<th>삭제</th>
				<tr>
				<tr>
					<td><%=result.get(i).getMember_no() %></td>
					<td><a href = "./memberAddrList.jsp?no=<%=result.get(i).getMember_no() %>"><%=result.get(i).getMember_name() %></a></td>
					<td><%=result.get(i).getMember_age()%></td>
					<td><a href = "./insertMemberaddrForm.jsp?no=<%=result.get(i).getMember_no() %>">주소입력</a></td>
					<td><a href = "./updateMemberForm.jsp?no=">수정</a></td>
					<td><a href = "./deleteMember.jsp?no=">삭제</a></td>
					<!-- updateMemberForm -> updateMemberAction-->
				</tr>
			</table>
		<%
			}
		%>	
		
	
		<%
		if(currentPage > 1) {
		
		%>
		<a href="./memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<% 
		}
		if(currentPage < lastPage){
		%>
		
		<a href="./memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
		}
		%>

	</body>
</html>