<!-- 2018.07.02 송원민 페이징 model1 작업 ArrayList 처리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.Memberdao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="service.Member" %>

<!DOCTYPE html>
<%
	int pagePerRow = 4; //한화면당 나오는 행의 갯수
	int currentPage = 1; //첫페이지
	if(request.getParameter("currentPage") != null){ 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	Memberdao dao = new Memberdao();
	ArrayList<Member> result = dao.selectMemberByPage(currentPage, pagePerRow);
	
	int lastPage = dao.paging(pagePerRow); //마지막 페이지
%>
<html>
	<head>
		<title>회원 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>회원 리스트</h1>
		</div>
		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/allMemberAddrList.jsp">회원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/allMemberAndScoreList.jsp">회원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/overMemberScoreList.jsp">평균점수이상의 회원 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<table border="1">
				<thead>
					<tr>
						<th>회원번호</th>
						<th>회원이름</th>
						<th>회원나이</th>
						<th>주소입력</th>
						<th>점수입력</th>
						<th>수정</th><!-- 수정페이지로 -->
						<th>삭제</th><!-- 삭제하고 바로 리스트로 이동 -->		
					</tr>
				</thead>
				<tbody>
				<%	
					for(int i=0; i<result.size(); i++) {
				%>

					<tr>
						<td><%=result.get(i).getMember_no() %></td>
						<td><a href = "<%= request.getContextPath() %>/Member/memberAddrList.jsp?no=<%=result.get(i).getMember_no() %>"><%=result.get(i).getMember_name() %></a></td>
						<td><%=result.get(i).getMember_age()%></td>
						<td><a href = "<%= request.getContextPath() %>/Member/insertMemberaddrForm.jsp?no=<%=result.get(i).getMember_no() %>">주소입력</a></td>
						<td><a href = "<%= request.getContextPath() %>/Member/insertMemberScoreForm.jsp?no=<%=result.get(i).getMember_no() %>">점수입력</a></td>
						<td><a href = "<%= request.getContextPath() %>/Member/updateMemberForm.jsp?no=<%=result.get(i).getMember_no() %>">수정</a></td>
						<td><a href = "<%= request.getContextPath() %>/Member/deleteMemberAction.jsp?no=<%=result.get(i).getMember_no() %>">삭제</a></td>
						<!-- updateMemberForm -> updateMemberAction-->
					</tr>
				<%
					}
				%>		
				</tbody>
			</table>
			<div>
			<%
				if(currentPage > 1) {
		
			%>
				<a href="<%= request.getContextPath() %>/Member/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<% 
				}
				if(currentPage < lastPage){
			%>
		
				<a href="<%= request.getContextPath() %>/Member/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a><br>
			<%
				}
			%>
			</div><br>
			<div><a href="<%=request.getContextPath() %>/Member/insertMemberForm.jsp">학생 정보 입력 페이지</a></div>
		</div>
		
		<div id="footer">
				COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>