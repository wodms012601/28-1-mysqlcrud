<!-- 탁재은, 2018.07.09 -->
<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	//페이징 작업
	int pagePerRow = 5; //한 페이지당 보는 갯수
	int currentPage = 1; //현재 페이지
	if(request.getParameter("currentPage") != null){ //페이지 이동 후 currentPage가 String타입이 되기때문에 int 데이터타입으로 변경
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//검색 작업
	String word = ""; //검색 초기값 공백
	if(request.getParameter("word") != null){
		word = request.getParameter("word"); //검색값이 들어오면 변수에 저장
	}
	
	StudentDao studentDao = new StudentDao();
	ArrayList<Student> studentList = studentDao.selectStudentByPage(currentPage, pagePerRow, word); //리스트 작업 후 배열객체의 주소값을 리턴
	
	int lastPage = studentDao.paging(pagePerRow); //페이징 작업 후 마지막 페이지값을 리턴
%>
<html>
	<head>
		<title>studentList</title>
	</head>
	<body>
		<form action="<%=request.getContextPath() %>/Student/studentList.jsp" method="post">
			<div><input type="text" name="word"></div> <!-- 검색입력폼 -->
			<input type="submit" value="검색">
		</form><br>
		<table border="1">
			<tr>
				<th>학생번호</th>
				<th>학생이름</th>
				<th>학생나이</th>
				<th>수정</th><!-- 수정페이지로 -->
				<th>삭제</th><!-- 삭제하고 바로 리스트로 이동 -->
				<th>점수입력</th>
			</tr>
			<%
				for(int i=0; i<studentList.size(); i++){
			%>
			<tr>
				<td><%=studentList.get(i).getStudentNo() %></td>
				<td><a href="<%=request.getContextPath() %>/Student/selectStudentAddr.jsp?no=<%=studentList.get(i).getStudentNo() %>"><%=studentList.get(i).getStudentName() %></a></td> <!-- 주소링크 -->
				<td><%=studentList.get(i).getStudentAge() %></td>
				<td><a href="<%=request.getContextPath() %>/Student/updateStudentForm.jsp?no=<%=studentList.get(i).getStudentNo() %>">수정</a></td>
				<td><a href="<%=request.getContextPath() %>/Student/deleteStudent.jsp?no=<%=studentList.get(i).getStudentNo() %>">삭제</a></td>
				<td><a href="<%=request.getContextPath() %>/Student/insertStudentScoreForm.jsp?no=<%=studentList.get(i).getStudentNo() %>">점수입력</a></td>
			</tr>
			<%
				}
			%>
		</table>
		<form>
			<!-- 검색 -->
		</form>
		<%
			if(currentPage > 1){
		%>
			<a href="<%=request.getContextPath() %>/Student/studentList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
		<%
			}
			for(int j=1; j<=lastPage; j++){
		%>
			<a href="<%=request.getContextPath() %>/Student/studentList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
		<%
			}
			if(currentPage < lastPage){
		%>
			<a href="<%=request.getContextPath() %>/Student/studentList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
		<%	
			}
		%>
		<br>
		<div><a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp">점수리스트</a></div>
		<div><a href="<%=request.getContextPath() %>/Student/studentAndScoreAboveAvgList.jsp">평균점수 이상의 학생들의 리스트</a></div><br>
		<div><a href="<%=request.getContextPath() %>/index.jsp">메인 페이지로</a></div>
	</body>
</html>