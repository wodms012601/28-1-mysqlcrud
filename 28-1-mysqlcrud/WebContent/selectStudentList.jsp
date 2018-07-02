<!-- 탁재은, 2018.07.02 -->
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	int pagePerRow = 5; //한 페이지당 보는 갯수
	int currentPage = 1; //현재 페이지
	if(request.getParameter("currentPage") != null){ //페이지 이동 후 currentPage가 String타입이 되기때문에 int 데이터타입으로 변경
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	StudentDao studentdao = new StudentDao();
	ArrayList<Student> list = studentdao.selectMemberByPage(currentPage, pagePerRow); //리스트 작업 후 배열객체의 주소값을 리턴
	
	int lastPage = studentdao.paging(pagePerRow); //페이징 작업 후 마지막 페이지를 int값으로 리턴 
%>
<html>
	<head>
		<title>selcetStudentList</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>학생번호</th>
				<th>학생이름</th>
				<th>학생나이</th>
			</tr>
			<%
				for(int i=0; i<list.size(); i++){
			%>
			<tr>
				<td><%=list.get(i).getStudentNo() %></td>
				<td><%=list.get(i).getStudentName() %></td>
				<td><%=list.get(i).getStudentAge() %></td>
			</tr>
			<%
				}
			%>
		</table>
		<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath() %>/selectStudentList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
		<%
			}
			for(int j=1; j<=lastPage; j++){
		%>
			<a href="<%=request.getContextPath() %>/selectStudentList.jsp?currentPage=<%=j %>"><%=j %></a>
		<%
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath() %>/selectStudentList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
		<%	
			}
		%>
	</body>
</html>