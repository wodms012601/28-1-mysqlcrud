<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="service.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>Insert title here</title>
	</head>
	
	<body>
		
		<%	
			String no = request.getParameter("no");
			System.out.println(no + "<--no값");
			
			Memberdao dao = new Memberdao();
			Member result = dao.selectUpdateNumber(no);
		%>
		<form action = "<%= request.getContextPath() %>/Member/updateMemberAction.jsp" method="post">
			<fieldset id = "box">
					<legend>회원수정화면</legend>
					
					<label for="1">Member_no</label>
						<input type = "text" name = "upno" value=<%=no%> readonly="readonly"><br/>
			
						<label for="2">Member_name</label>
						<input type = "text" name = "upname" value=<%=result.getMember_name()%>><br>
						<label for="2">Member_age</label>
						<input type = "text" name = "upage" value=<%=result.getMember_age()%>><br><br>
				<input type = "submit" value = "update">
			</fieldset>
		</form>
	</body>
</html>