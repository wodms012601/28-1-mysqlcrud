<!-- Ź����, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<title>insertStudentForm</title>
	</head>
	<body>
		<!-- ������ ���� Ȯ�ο� �׽�Ʈ �� -->
		<form action="<%= request.getContextPath()%>/insertStudentAction.jsp" method="post">
			<div>
				<input type="text" name="studentName">
			</div>
			<div>
				<input type="text" name="studentAge">
			</div>
			<div>
				<input type="submit" value="����">
			</div>
		</form>
	</body>
</html>