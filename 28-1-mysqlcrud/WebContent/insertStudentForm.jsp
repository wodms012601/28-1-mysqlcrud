<!-- 탁재은, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<title>insertStudentForm</title>
	</head>
	<body>
		<!-- 데이터 전송 확인용 테스트 폼 -->
		<form action="<%= request.getContextPath()%>/insertStudentAction.jsp" method="post">
			<div>
				<input type="text" name="studentName">
			</div>
			<div>
				<input type="text" name="studentAge">
			</div>
			<div>
				<input type="submit" value="전송">
			</div>
		</form>
	</body>
</html>