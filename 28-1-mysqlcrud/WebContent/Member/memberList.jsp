<!-- 2018.07.02 송원민 페이징 model1 작업 ArrayList 처리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int pagePerRow = 4; //한화면당 나오는 행의 갯수
	int currentPage = 1; //첫페이지
	if(request.getParameter("currentPage") != null){ 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//검색 작업
	String nameKeyword = ""; //검색 초기값 공백
	if(request.getParameter("nameKeyword") != null){
		nameKeyword = request.getParameter("nameKeyword"); //검색값이 들어오면 변수에 저장
		
		request.getSession().setAttribute("nameKeyword", nameKeyword);
	} else if(request.getSession().getAttribute("nameKeyword") != null){ 

		nameKeyword = (String)request.getSession().getAttribute("nameKeyword");
	}
	
	Memberdao dao = new Memberdao();
	ArrayList<Member> result = dao.selectMemberByPage(currentPage, pagePerRow, nameKeyword);
	
	int lastPage = dao.paging(pagePerRow, nameKeyword); //마지막 페이지
%>
<html>
	<head>
		<title>회원 리스트</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>회원 리스트</h1>
		</div>
		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberList.jsp">회원 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAddrList.jsp">회원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAndScoreList.jsp">회원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/memberAndScoreAboveAvgList.jsp">평균점수이상의 회원 리스트</a></li>
			</ul>
		</div>
		<div id="content">
			<form action="<%=request.getContextPath() %>/Member/memberList.jsp" method="post">
				<div>검색 : &nbsp;<input type="text" name="nameKeyword"> &nbsp; <input type="submit" value="검색"></div> <!-- 검색입력폼 -->
			</form><br>
			<table border="1">
				<thead>
					<tr>
						<th>회원번호</th>
						<th>회원이름</th>
						<th>회원나이</th>
						<th>수정</th><!-- 수정페이지로 -->
						<th>삭제</th><!-- 삭제하고 바로 리스트로 이동 -->		
						<th>주소입력</th>
						<th>점수입력</th>
						<th>점수보기</th>
						
					</tr>
				</thead>
				<tbody>
				<%	
					for(int i=0; i<result.size(); i++) {
				%>
					<tr>
						<td><%=result.get(i).getMember_no() %></td>
						<td><a href = "<%= request.getContextPath() %>/Member/selectMemberAddrList.jsp?no=<%=result.get(i).getMember_no() %>"><%=result.get(i).getMember_name() %></a></td>
						<td><%=result.get(i).getMember_age()%></td>
						<td><a href = "<%= request.getContextPath() %>/Member/updateMemberForm.jsp?no=<%=result.get(i).getMember_no() %>">수정</a></td>
						<td><a href = "<%= request.getContextPath() %>/Member/deleteMemberAction.jsp?no=<%=result.get(i).getMember_no() %>">삭제</a></td>
						<td><a href = "<%= request.getContextPath() %>/Member/insertMemberaddrForm.jsp?no=<%=result.get(i).getMember_no() %>">주소입력</a></td>
					<%
						MemberScoreDao memberScore = new MemberScoreDao();
						/*학생 번호를 매개변수로 학생점수를 검색하는 메서드 호출한다
						그리고 학생 점수데이터가 있는 객체의 주소값을 리턴받는다*/
						MemberScore studentNo = memberScore.selectScore(result.get(i).getMember_no());
						System.out.println(studentNo  +"--이거");
						
						if(studentNo == null){ 
					%>
							<td><a href = "<%= request.getContextPath() %>/Member/insertMemberScoreForm.jsp?no=<%=result.get(i).getMember_no() %>">점수입력</a></td>
					<%		
						} else {
					%>
							<td><a href = "<%= request.getContextPath() %>/Member/updateMemberScoreForm.jsp?no=<%=result.get(i).getMember_no() %>&name=<%=result.get(i).getMember_name() %>">점수수정</a></td>
					<%		
						}
					%>		
						<td><a href = "<%= request.getContextPath() %>/Member/selectMemberScoreList.jsp?no=<%=result.get(i).getMember_no() %>&name=<%=result.get(i).getMember_name() %>">점수보기</a></td>
						
						<!-- updateMemberForm -> updateMemberAction-->
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
				<a href="<%=request.getContextPath() %>/Member/memberList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
			<%
				}
				for(int j=1; j<=lastPage; j++){
			%>
				<a href="<%=request.getContextPath() %>/Member/memberList.jsp?currentPage=<%=j %>"><%=j %></a> <!-- 1 ~ 마지막페이지까지 링크 -->
			<%
				}
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath() %>/Member/memberList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
			<%	
				}
			%>
			</div><br>
			<div><a href="<%=request.getContextPath() %>/Member/insertMemberForm.jsp">학생 정보 입력 페이지</a></div>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>