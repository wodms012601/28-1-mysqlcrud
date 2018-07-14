<!-- 전체 회원 리스트  -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<%	
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");	

	int pagePerRow = 7; //한화면당 나오는 행의 갯수
	int currentPage = 1; //첫페이지
	if(request.getParameter("currentPage") != null){ 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	//검색 작업
	String addrKeyword = ""; //검색 초기값 공백
	if(request.getParameter("addrKeyword") != null){
		addrKeyword = request.getParameter("addrKeyword"); //검색값이 들어오면 변수에 저장
	
		request.getSession().setAttribute("addrKeyword", addrKeyword);
	} else if(request.getSession().getAttribute("addrKeyword") != null){ 

		addrKeyword = (String)request.getSession().getAttribute("addrKeyword");
	}	

	MemberAddrDao dao4 = new MemberAddrDao();
	ArrayList<MemberAddr> result = dao4.selectMemberAddrList(currentPage, pagePerRow, addrKeyword);
	
	int lastPage = dao4.paging(pagePerRow, addrKeyword); //마지막 페이지
%>
<html>
	<head>
		<title>전체회원 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>전체회원 리스트</h1>
		</div>
		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberList.jsp">회원 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAddrList.jsp">회원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAndScoreList.jsp">회원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAndScoreAboveAvgList.jsp">평균점수이상의 회원 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<table border="1">
				<tr>
					<th>주소번호</th>
					<th>회원주소번호</th>
					<th>회원주소</th>
				</tr>
		<%	
			for(int i=0; i<result.size(); i++) {
		%>
				<tr>
					<td><%=result.get(i).getMemberaddr().getMemberAddrNo() %></td>
					<td><%=result.get(i).getMember().getMember_name() %></td>
					<td><%=result.get(i).getMemberaddr().getMemberAddrContent() %></td>
				</tr>		
		<%		
			}
		%>
		</table>
		
		<form action="<%=request.getContextPath() %>/Member/memberAddrList.jsp" method="post">
				<div><input type="text" name="addrKeyword"> &nbsp; <input type="submit" value="주소검색"></div> <!-- 검색입력폼 -->
		</form><br>
		
		<div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Member/memberAddrList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
			<%
				}
				for(int j=1; j<=lastPage; j++){
			%>
				<a href="<%=request.getContextPath() %>/Member/memberAddrList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Member/memberAddrList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
			<%	
				}
			%>
		</div><br>
		<div id="footer">
				COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>