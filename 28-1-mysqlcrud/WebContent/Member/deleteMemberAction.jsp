<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			String no = request.getParameter("no");
			System.out.println(no + "<--넘겨받은 번호값");	
		
			Memberdao dao = new Memberdao();
			dao.deleteScoreMember(no);
			dao.deleteAddrMember(no);
			dao.deleteMember(no);
		
			response.sendRedirect(request.getContextPath() + "/Member/memberList.jsp");
		%>
	</body>
</html>