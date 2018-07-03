<!-- 탁재은, 2018.07.03 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no")); //어느 학생을 보려고 했는지 알기위해 no값을 넘겨줌
	StudentDao studentDao = new StudentDao();
	Student student = studentDao.selectStudent(studentNo); //객체에서 메서드를 생성해 select문으로 이름과 나이값을 찾음
	
	StudentAddrDao studentAddrDao = new StudentAddrDao();
	StudentAddr studentAddr = studentAddrDao.selectStudentAddr(studentNo); //주소객체에서 메서드를 이용해 select문으로 학생주소를 찾음 
%>
<html>
	<head>
		<title>updateStudentForm</title>
	</head>
	<body>
		<!-- 수정페이지 -->
		<form action="<%= request.getContextPath()%>/Student/updateStudentAction.jsp?no=<%=studentNo %>" method="post">
			<fieldset>
				<legend>개인 정보</legend>
				<table>
					<tr><!-- 이름 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>이름 :&nbsp;</td>
						<td>
							<input type="text" name="studentName" value="<%=student.getStudentName() %>">
						</td>
					</tr>
					<tr><!-- 나이 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>나이 :&nbsp;</td>
						<td colspan="3">
							<input type="text" name="studentAge" value="<%=student.getStudentAge() %>">
						</td>
					</tr>
					<tr><!-- 주소 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>주소 :&nbsp;</td>
						<td colspan="3">
							<input type="text" name="studentAddrContent" size="40" value="<%=studentAddr.getStudentAddrContent() %>">
						</td>
					</tr>
				</table>
			</fieldset><br>
			<fieldset>
				<input type="submit" value="수정">
			</fieldset>
		</form>
	</body>
</html>