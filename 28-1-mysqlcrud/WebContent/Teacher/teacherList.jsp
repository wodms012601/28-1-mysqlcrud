<!-- 28th Choi Yun-Seok, 2018.07.13 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Teacher List</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	// 페이징
	int currentPage = 1;
	int pagePerRow = 7;
	
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String keyword = ""; // 키워드 초기값

	// 검색 키워드 세션 검색 결과 페이지 유지
	if(request.getParameter("keyword") != null){

		keyword = request.getParameter("keyword");

		request.getSession().setAttribute("keyword", keyword);

	}else if(request.getSession().getAttribute("keyword") != null){ 

		keyword = (String)request.getSession().getAttribute("keyword");

	}

	TeacherDao teacherDao = new TeacherDao();
	ArrayList<Teacher> teacherList = teacherDao.selectTeacherByPage(currentPage, pagePerRow, keyword);
	
	int lastPage = teacherDao.paging(pagePerRow, keyword); // 마지막 페이지 값 리턴

%>
 	<div id="header">
		<h1>Teacher List</h1>
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

	<div id="content">
	    <table border="1">
	        <thead>
	            <tr>
	                <th>선생님번호</th>
	                <th>선생님이름</th>
	                <th>선생님나이</th>
	                <th>수정</th>
	                <th>삭제</th>
	                <th>주소입력</th>
	                <th>점수입력</th>
	                <th>점수보기</th>
	            </tr>
	        </thead>
	        <tbody>
<%
					for(int i=0; i<teacherList.size(); i++){
%>
	                <tr>
	                    <td><%=teacherList.get(i).getTeacher_no()%></td>
	                    <td><a href="selectTeacherAddr.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>"><%=teacherList.get(i).getTeacherName()%></a></td>
	                    <td><%=teacherList.get(i).getTeacherAge()%></td>
						<td><a href="updateTeacherForm.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">수정</a></td>
						<td><a href="deleteTeacher.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">삭제</a></td>
	                    <td><a href="insertTeacherAddrForm.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">주소입력</a></td>
<%
						TeacherScoreDao teacherScoreDao = new TeacherScoreDao();
						TeacherScore teacherId = teacherScoreDao.selectScoreCount(teacherList.get(i).getTeacher_no());
						if(teacherId.getTeacherNo() == 0) {
%>
						<td><a href="insertTeacherScoreForm.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">점수입력</a></td>
<%
						} else {
%>	           
						<td><a href="updateTeacherScoreForm.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">점수수정</a></td>     
<%
						}
%>						    

						<td><a href="selectTeacherScore.jsp?send_id=<%=teacherList.get(i).getTeacher_no()%>">점수보기</a></td>
	                    
	                </tr>
<%
            }
%>
	        </tbody>
	    </table>
	    <br>
	    <form action="<%=request.getContextPath() %>/Teacher/teacherList.jsp" method="get">
	    		<input type = "text" name="keyword">
	    		<input type="submit" value = "이름검색">
	    	
	    </form>

	    <div>
			<%
				if(currentPage > 1){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp?currentPage=<%=currentPage-1 %>&keyword=<%=keyword%>">이전</a>
			<%
				}
				for(int L=1; L<=lastPage; L++){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp?currentPage=<%=L%>&keyword=<%=keyword%>"><%=L%></a>
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Teacher/teacherList.jsp?currentPage=<%=currentPage+1 %>&keyword=<%=keyword%>">다음</a>
			<%	
				}
			%>
	    </div>
	    <br>
	    <br>
	    <br>
	    <a href="<%=request.getContextPath() %>/Teacher/insertTeacherForm.jsp">등록 페이지로 이동</a>
	</div>

	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>

</body>
</html>