<!-- 탁재은, 2018.07.09 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	//페이징 작업
	int pagePerRow = 5; //한 페이지당 보는 갯수
	int currentPage = 1; //현재 페이지
	if(request.getParameter("currentPage") != null){ //페이지 이동 후 currentPage가 String타입이 되기때문에 int 데이터타입으로 변경
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	StudentScoreDao studentScore = new StudentScoreDao();
	//학생 테이블과 점수 테이블을 조인하는 메서드를 호출하고 학생 객체와 학생점수 객체의 주소값이 저장된 조인객체의 주소값을 담은 배열객체를 리턴받는다.
	ArrayList<StudentAndScore> studentJoin = studentScore.studentScoreJoin(currentPage, pagePerRow);
	
	int lastPage = studentScore.paging(pagePerRow); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>학생점수 리스트</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>학생번호</th>
				<th>학생이름</th>
				<th>학생나이</th>
				<th>학생점수</th>
			</tr>
		<%
			for(int i=0; i<studentJoin.size(); i++){
		%>
			<tr>
				<td><%=studentJoin.get(i).getStudent().getStudentNo() %></td> <!-- 학생 번호 -->
				<td><%=studentJoin.get(i).getStudent().getStudentName() %></td> <!-- 학생 이름 -->
				<td><%=studentJoin.get(i).getStudent().getStudentAge() %></td> <!-- 학생 나이 -->
				<td><%=studentJoin.get(i).getStudentScore().getScore() %></td> <!-- 학생 점수 -->
			</tr>
		<%
			}
		%>
		</table>
		<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
		<%
			}
			for(int j=1; j<=lastPage; j++){
		%>
			<a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
		<%
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
		<%	
			}
		%>
		<br>
		<div><a href="<%=request.getContextPath() %>/Student/studentAndScoreAboveAvgList.jsp">평균점수 이상의 학생들의 리스트</a></div>
		<div><a href="<%=request.getContextPath() %>/Student/studentList.jsp">학생 리스트 페이지로</a></div><br>
		<div><a href="<%=request.getContextPath() %>/index.jsp">메인 페이지로</a></div>
	</body>
</html>