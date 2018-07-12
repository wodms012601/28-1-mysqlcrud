<!-- 탁재은, 2018.07.12 -->
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
		<title>학생 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>학생 리스트</h1>
		</div>
		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAddrList.jsp">학생주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAndScoreList.jsp">학생점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Student/studentAndScoreAboveAvgList.jsp">평균점수이상의 학생 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<form action="<%=request.getContextPath() %>/Student/studentList.jsp" method="post">
				<div>검색 : &nbsp;<input type="text" name="word"> &nbsp; <input type="submit" value="검색"></div> <!-- 검색입력폼 -->
			</form><br>
			<table border="1">
				<thead>
					<tr>
						<th>학생번호</th>
						<th>학생이름</th>
						<th>학생나이</th>
						<th>수정</th><!-- 수정페이지로 -->
						<th>삭제</th><!-- 삭제하고 바로 리스트로 이동 -->
						<th>점수입력</th>
						<th>점수보기</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(int i=0; i<studentList.size(); i++){
				%>
					<tr>
						<td><%=studentList.get(i).getStudentNo() %></td>
						<td><a href="<%=request.getContextPath() %>/Student/selectStudentAddr.jsp?no=<%=studentList.get(i).getStudentNo() %>"><%=studentList.get(i).getStudentName() %></a></td> <!-- 주소링크 -->
						<td><%=studentList.get(i).getStudentAge() %></td>
						<td><a href="<%=request.getContextPath() %>/Student/updateStudentForm.jsp?no=<%=studentList.get(i).getStudentNo() %>">수정</a></td>
						<td><a href="<%=request.getContextPath() %>/Student/deleteStudent.jsp?no=<%=studentList.get(i).getStudentNo() %>">삭제</a></td>
					<%
						StudentScoreDao studentScoreDao = new StudentScoreDao();
						/*학생 번호를 매개변수로 학생점수를 검색하는 메서드 호출한다
						그리고 학생 점수데이터가 있는 객체의 주소값을 리턴받는다*/
						StudentScore studentNo = studentScoreDao.selectStudentScore(studentList.get(i).getStudentNo());
						if(studentNo.getStudentNo() == 0){ //학생점수가 입력되지않은 상태면 리턴값으로 0이 나온다.
					%>
						<td><a href="<%=request.getContextPath() %>/Student/insertStudentScoreForm.jsp?no=<%=studentList.get(i).getStudentNo() %>">점수입력</a></td>
					<%
						} else {
					%>
						<td><a href="<%=request.getContextPath() %>/Student/updateStudentScoreForm.jsp?no=<%=studentList.get(i).getStudentNo() %>">점수수정</a></td>
					<%
						}
					%>
						<td><a href="<%=request.getContextPath() %>/Student/selectStudentScore.jsp?no=<%=studentList.get(i).getStudentNo() %>">점수보기</a></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<div>
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
			</div><br>
			<div><a href="<%=request.getContextPath() %>/Student/insertStudentForm.jsp">학생 정보 입력 페이지</a></div>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>