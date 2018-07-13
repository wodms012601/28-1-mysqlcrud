<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>선생님주소 리스트</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
	<div id="header">
		<h1>선생님주소 리스트</h1>
	</div>
	
	<div id="sidebar_a">
		<ul>
			<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp">선생님 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAddrList.jsp">주소 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">점수 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreAboveAvgList.jsp">평균점수 이상 리스트</a></li>
		</ul>
	</div>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 페이징
	int currentPage = 1;
	int pagePerRow = 7;
	
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String addrKeyword = ""; // 키워드 초기값

	// 검색 키워드 세션 검색 결과 페이지 유지
	if(request.getParameter("addrKeyword") != null){

		addrKeyword = request.getParameter("addrKeyword");

		request.getSession().setAttribute("addrKeyword", addrKeyword);

	}else if(request.getSession().getAttribute("addrKeyword") != null){ 

		addrKeyword = (String)request.getSession().getAttribute("addrKeyword");

	}

	TeacherAddrDao teacherAddrDao = new TeacherAddrDao();
	ArrayList<TeacherAddr> teacherAddrList = teacherAddrDao.selectTeacherAddrList(currentPage, pagePerRow, addrKeyword);
	
	int lastPage = teacherAddrDao.Paging(pagePerRow, addrKeyword); // 마지막 페이지 값 리턴

%>
	<div id="content">
	    <table border="1">
	        <thead>
	            <tr>
	                <th>주소번호</th>
	                <th>선생님번호</th>
	                <th>선생님주소</th>
	            </tr>
	        </thead>
	        <tbody>
<%
				   for(int i=0; i<teacherAddrList.size(); i++){
%>
             	   <tr>
           	         <td><%=teacherAddrList.get(i).getTeacher_addr_no()%></td>
           	         <td><%=teacherAddrList.get(i).getTeacher_no()%></td>
           	         <td><%=teacherAddrList.get(i).getTeacher_addr_content()%></td>
          	       </tr>
<%        
            }
%>
	        </tbody>
	    </table>
	    <br>
	    <form action="<%=request.getContextPath() %>/Teacher/teacherAddrList.jsp" method="get">
	    		<input type = "text" name="addrKeyword">
	    		<input type="submit" value = "주소검색">
	    	
	    </form>

	    <div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAddrList.jsp?currentPage=<%=currentPage-1 %>&addrKeyword=<%=addrKeyword%>">이전</a>
			<%
				}
				for(int L=1; L<=lastPage; L++){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAddrList.jsp?currentPage=<%=L%>&addrKeyword=<%=addrKeyword%>"><%=L%></a>
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherAddrList.jsp?currentPage=<%=currentPage+1 %>&addrKeyword=<%=addrKeyword%>">다음</a>
			<%	
				}
			%>
		</div>
	</div>

	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
</body>
</html>