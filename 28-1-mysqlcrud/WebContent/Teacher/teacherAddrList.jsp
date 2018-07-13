<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>teacher Addr List</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
	<div id="header">
		<h1>teacher Addr List</h1>
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
	int currentPage = 1; // 현재 페이지
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage")); // 인트 변환
	}
	TeacherAddrDao teacherDao = new TeacherAddrDao();
	int totalRowCount = teacherDao.selectTotalTeacherCountAddr(); // 전체 행의 수
	int pagePerRow = 7; // 한 페이지당 보이는 수
	int beginRow = (currentPage-1)*pagePerRow;
	ArrayList<TeacherAddr> list = teacherDao.selectTeacherAddr(beginRow, pagePerRow); // 주소값 리턴
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
          	  for(TeacherAddr a : list) {
%>
             	   <tr>
           	         <td><%=a.getTeacher_addr_no()%></td>
           	         <td><%=a.getTeacher_no()%></td>
           	         <td><%=a.getTeacher_addr_content()%></td>
          	       </tr>
<%        
            }
%>
	        </tbody>
	    </table>
<%
    int lastPage = totalRowCount/pagePerRow; // 마지막 페이지
    if(totalRowCount%pagePerRow != 0) {
        lastPage++;
    }
%>
    <div>
<%
        if(currentPage>1) {
%>
            <a href="<%=request.getContextPath()%>/Teacher/teacherAddrList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%
        }
        if(currentPage<lastPage) {
%>
 
            <a href="<%=request.getContextPath()%>/Teacher/teacherAddrList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%
        }
%>
	</div>
	    <br>
	    <br>
	    <br>
	    <a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp">돌아가기</a>
	</div>

	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>
</body>
</html>