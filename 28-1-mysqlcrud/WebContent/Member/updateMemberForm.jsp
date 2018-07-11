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
			String name = request.getParameter("name");
			String age = request.getParameter("age");
			System.out.println(no + "<--no값");
			System.out.println(name+ "<--name값");
			System.out.println(age + "<--age값");
		%>
		<form action = "<%= request.getContextPath() %>/Member/updateMemberAction.jsp" method="post">
			<fieldset id = "box">
					<legend>회원수정화면</legend>
					
					<label for="1">Member_no</label>
						<input type = "text" name = "up_no" value=<%=no%> readonly="readonly"><br/>
			
						<label for="2">Member_name</label>
						<input type = "text" name = "up_name" value=<%= %>><br/><br/>
						
						<label for="2">Member_age</label>
						<input type = "text" name = "up_age" value=<%= %>><br/><br/>
				<input type = "submit" value = "update">
			</fieldset>
		</form>
	</body>
</html>