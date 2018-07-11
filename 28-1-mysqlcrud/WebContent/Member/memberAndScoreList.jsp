<!-- 서브쿼리만 사용하여 평균이상의 학생들을 화면에 출력 -->
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
			int pagePerRow = 3; //한화면당 나오는 행의 갯수
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
						<td><%=result1.get(i).getMemberScore().getMemberScoreNo()%></td>
						<td><%=result1.get(i).getMember().getMember_no() %></td>
						<td><%=result1.get(i).getMemberScore().getScore() %></td>
					</tr>
				</table>
		<%		
			}
		%>
		<%
		if(currentPage > 1) {
		
		%>
		<a href="<%= request.getContextPath() %>/Member/memberAndScoreList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<% 
		}
		if(currentPage < lastPage){
		%>
		
		<a href="<%= request.getContextPath() %>/Member/memberAndScoreList.jsp?currentPage=<%=currentPage+1%>">다음</a><br>
		<%
		}
		%>
		<a href="<%= request.getContextPath() %>/index.jsp">돌아가기</a>
	</body>
</html>