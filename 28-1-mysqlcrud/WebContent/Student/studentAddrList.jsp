<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	//페이징 작업
	int pagePerRow = 7; //한 페이지당 보는 갯수
	int currentPage = 1; //현재 페이지
	if(request.getParameter("currentPage") != null){ //페이지 이동 후 currentPage가 String타입이 되기때문에 int 데이터타입으로 변경
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
	
	StudentAddrDao studentAddrDao = new StudentAddrDao();
	//학생 주소를 검색하는 메서드를 호출하고 학생 주소데이터가 담긴 객체의 주소값을 담은 배열객체의 주소값을 리턴받는다.
	ArrayList<StudentAddr> studentAddrList = studentAddrDao.selectStudentAddrList(currentPage, pagePerRow, addrKeyword);
	
	int lastPage = studentAddrDao.paging(pagePerRow, addrKeyword); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>학생주소 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>학생주소 리스트</h1>
		</div>
		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentList.jsp">학생 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAddrList.jsp">학생주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp">학생점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAndScoreAboveAvgList.jsp">평균점수이상의 학생 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<table border="1">
				<tr>
					<th>주소번호</th>
					<th>학생번호</th>
					<th>학생주소</th>
				</tr>
			<%
				for(int i=0; i<studentAddrList.size(); i++){
			%>
				<tr>
					<td><%=studentAddrList.get(i).getStudentAddrNo() %></td>
					<td><%=studentAddrList.get(i).getStudentNo() %></td>
					<td><%=studentAddrList.get(i).getStudentAddrContent() %></td>
				</tr>
			<%	
				}
			%>
			</table><br>
			<form action="<%=request.getContextPath() %>/Student/studentAddrList.jsp" method="post">
				<div><input type="text" name="addrKeyword"> &nbsp; <input type="submit" value="주소검색"></div> <!-- 검색입력폼 -->
			</form>
			<div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Student/studentAddrList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
			<%
				}
				for(int j=1; j<=lastPage; j++){
			%>
				<a href="<%=request.getContextPath() %>/Student/studentAddrList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Student/studentAddrList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
			<%	
				}
			%>
			</div><br>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>