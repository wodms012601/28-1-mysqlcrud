<!-- 07.10 송원민 : 회원주소삽입 화면 작업 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
 		<div id="header">
			<h1>회원 주소 입력창</h1>
		</div>

		<div id="sidebar_a">
			<ul>
				<li><a href="<%=request.getContextPath() %>/index.jsp">메인페이지로</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/allMemberAddrList.jsp">회원주소 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/allMemberAndScoreList.jsp">회원점수 리스트</a></li>
				<li><a href="<%=request.getContextPath() %>/Member/overMemberScoreList.jsp">평균점수이상의 회원 리스트</a></li>
			</ul>
		</div>
	<%
		String no = request.getParameter("no"); // memberList회원번호 
	%>
	
		<div id="content">	
			<form action = "<%= request.getContextPath() %>/Teacher/insertTeacherAddrAction.jsp" method="post">
				<fieldset id = "box">
					<legend><h2>회원 주소 입력창</h2></legend>
						<br>
						<br>
						<label for="1">member_no</label>
						<input type = "text" name = "Member_no" value=<%=no%> readonly="readonly"> <br/>

						<label for="2">member_addr_content</label>
						<input type = "text" name = "Member_addr_content" required > <br/> <br/>

						<input type = "submit" value = "insert">
						<br>
						<br>
				</fieldset>
			</form>
		</div>

		<div id="footer">
			COPYRIGHT(C) 1조 프로젝트  All Rights Reserved.
		</div>
	</body>
</html>