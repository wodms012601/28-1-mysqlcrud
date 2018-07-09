<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<%
		String no = request.getParameter("no");
	%>
	
	<form action = "<%= request.getContextPath() %>/Member/insertMemberaddrAction.jsp" method="post">
		<fieldset id = "box">
				<legend>insert Member Addr Form</legend>
				
				<label for="1">Member_no</label>
					<input type = "text" name = "Member_no" value=<%=no%> readonly="readonly"> <br/>
			
					<label for="2">Member_addr_content</label>
					<input type = "text" name = "Member_addr_content"> <br/> <br/>
				
			<input type = "submit" value = "insert">
		</fieldset>
	</form>
</body>
</html>