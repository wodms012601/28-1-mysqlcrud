<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Select Teacher List</title>
<style>
body {
width:800px;
margin:0 auto;
}

#header {
margin:0 0 10px 0;
padding:10px;
border:1px solid #000;
background-color:#DAD9FF;
width:800px;
}

#content {
float:left;
padding:10px;
background-color:#D4F4FA;
border:1px solid #000;
width:800px;
margin-bottom:10px;
}

#sidebar_a {
float:left;
padding:10px;
border:1px solid #000;
width:800px;
background-color:#D9E5FF;
}

#footer {
clear:both;
padding:10px;
border:1px solid #000;
background-color:#E8D9FF;
width:800px;
}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	int currentPage = 1;
	int pagePerRow = 10;
	
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String keyword = "";


	if(request.getParameter("keyword") != null){

		keyword = request.getParameter("keyword");

		request.getSession().setAttribute("keyword", keyword);

	}else if(request.getSession().getAttribute("keyword") != null){ 

		keyword = (String)request.getSession().getAttribute("keyword");

	}
		
	TeacherDao teacherDao = new TeacherDao();
	ArrayList<Teacher> teacherList = teacherDao.selectTeacherByPage(currentPage, pagePerRow, keyword);
	
	int lastPage = teacherDao.teacherPaging(pagePerRow);
	
%>
 	<div id="header">
		<h1>Select Teacher List</h1>
	</div>
	
	<div id="sidebar_a">
		<ul>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">선생님 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherAddrList.jsp">주소 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">점수 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherListAboveAvg.jsp">평균점수 이상 리스트</a></li>
		</ul>
	</div>
	
	<div id="content">
	    <table border="1">
	        <thead>
	            <tr>
	                <th>teacher_no</th>
	                <th>teacher_name</th>
	                <th>teacher_age</th>
	                <th>주소입력</th>
	                <th>점수입력</th>
	                <th>삭제</th>
	                <th>수정</th>
	                <th>조인</th>
	                <th>평균점수</th>
	            </tr>
	        </thead>
	        <tbody>
<%
					for(int i=0; i<teacherList.size(); i++){
%>
	                <tr>
	                    <td><%=teacherList.get(i).getTeacher_no()%></td>
	                    <td><a href="teacherAddrList.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>"><%=teacherList.get(i).getTeacherName()%></a></td>
	                    <td><%=teacherList.get(i).getTeacherAge()%></td>
	                    <td><a href="insertTeacherAddrForm.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">주소입력</a></td>
	                    <td><a href="insertTeacherScoreForm.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">점수입력</a></td>
	                    <td><a href="deleteTeacherAction.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">삭제</a></td>
	                    <td><a href="updateTeacherForm.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">수정</a></td>
	                    <td><a href="teacherAndScoreList.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">조인</a></td>
	                    <td><a href="teacherListAboveAvg.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">평균점수</a></td>
	                </tr>
<%        
            }
%>
	        </tbody>
	    </table>
	    <br>
	    <form action="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp" method="post">
	    		<input type = "text" name="keyword">
	    		<input type="submit" value = "검색하기">
	    	
	    </form>
	    
	    <div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
			<%
				}
				for(int L=1; L<=lastPage; L++){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp?currentPage=<%=L%>"><%=L%></a>
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
			<%	
				}
			%>
	    </div>
	    <br>
	    <br>
	    <br>
	    <a href="<%=request.getContextPath() %>/Teacher/insertTeacherForm.jsp">돌아가기</a>
	</div>
	
	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>

</body>
</html>