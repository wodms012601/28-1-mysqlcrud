<!-- 2018-06-26 28�� �ۿ��� ��1 insert �۾� -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>Insert title here</title>
	</head>
	
	<body>
		<form action="<%=request.getContextPath() %>/insertMemberAction.jsp" method="post">
			<input type="text" name="name">
			<input type="text" name="age">
			<input type="text" name="addr_content">
			<input type="submit" value="������">
		</form>
	</body>
</html>