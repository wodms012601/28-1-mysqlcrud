<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			int pagePerRow = 4; //한화면당 나오는 행의 갯수
			int currentPage = 1; //첫페이지
			if(request.getParameter("currentPage") != null){ 
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
			
			MemberScoreDao dao2 = new MemberScoreDao();
			
			ArrayList<MemberAndScore> result1= dao2.selectMemberListAvg(currentPage, pagePerRow);
			
			int lastPage = dao2.paging(pagePerRow); //마지막 페이지
		%>
		
		<%
			for(int i=0; i<result1.size(); i++) {
		%>
		
				<table border="1">
					<tr>
						<td>회원번호</td>
						<td>회원이름</td>
						<td>점수</td>
					</tr>
					<tr>
						<td><%=result1.get(i).getMember().getMember_no() %></td>
						<td><%=result1.get(i).getMember().getMember_name() %></td>
						<td><%=result1.get(i).getMemberScore().getScore() %></td>
					</tr>
				</table>
		<%		
			}
		%>
		<a href="<%= request.getContextPath() %>/Member/overMemberScoreList.jsp">90점이상회원리스트</a><br>
		<%
		if(currentPage > 1) {
		
		%>
		<a href="<%= request.getContextPath() %>/Member/memberAndScoreList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<% 
		}
		if(currentPage < lastPage){
		%>
		
		<a href="<%= request.getContextPath() %>/Member/memberAndScoreList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
		}
		%>
	</body>
</html>