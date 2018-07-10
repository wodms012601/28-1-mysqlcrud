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
	int currentPage = 1; // 현재 페이지
	if(request.getParameter("currentPage") != null) {
	    currentPage = Integer.parseInt(request.getParameter("currentPage")); // 인트 변환
	}
	TeacherAddrDao teacherDao = new TeacherAddrDao();
	int totalRowCount = teacherDao.selectTotalTeacherCountAddr(); // 전체 행의 수
	int pagePerRow = 10; // 한 페이지당 보이는 수
	int beginRow = (currentPage-1)*pagePerRow;
	ArrayList<TeacherAddr> list = teacherDao.selectTeacherAddr(beginRow, pagePerRow); // 주소값 리턴
%>
 
    <div>전체행의 수 : <%=totalRowCount%> / 현재행의 수: <%=list.size()%></div>
    <table border="1">
        <thead>
            <tr>
                <th>teacher_addr_no</th>
                <th>teacher_no</th>
                <th>teacher_addr_content</th>
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
    
    <form>
    	<div>
    		이름 :
    		<input type = "text" name="searchWord">
    		<button type = "button">검색</button>
    	</div>
    </form>
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
            <a href="<%=request.getContextPath()%>/Teacher/selectTeacherAddrList.jsp?currentPage=<%=currentPage-1%>">이전</a>
<%
        }
        if(currentPage<lastPage) {
%>
 
            <a href="<%=request.getContextPath()%>/Teacher/selectTeacherAddrList.jsp?currentPage=<%=currentPage+1%>">다음</a>
<%
        }
%>
    </div>

</body>
</html>