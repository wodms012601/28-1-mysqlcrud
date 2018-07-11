<!-- 07.10 송원민 : 회원주소삽입 화면 작업 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<%
		String no = request.getParameter("no"); // memberList회원번호 
	%>
	
	<form action = "<%= request.getContextPath() %>/Member/insertMemberaddrAction.jsp" method="post">
		<fieldset id = "box">
				<legend>회원주소정보삽입</legend>
				
				<label for="1">Member_no</label>
					<input type = "text" name = "Member_no" value=<%=no%> readonly="readonly"> <br/>
			
					<label for="2">Member_addr_content</label>
					<input type = "text" name = "Member_addr_content"> <br/> <br/>
				
			<input type = "submit" value = "insert">
		</fieldset>
	</form>
</body>
</html>