<!-- 28th Choi Yun-Seok, 2018.07.9 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="service.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
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
	}
		
	TeacherDao teacherDao = new TeacherDao();
	ArrayList<Teacher> teacherList = teacherDao.selectTeacherByPage(currentPage, pagePerRow, keyword);
	
	int lastPage = teacherDao.teacherPaging(pagePerRow);
	
%>
 
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

</body>
</html>