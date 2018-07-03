<!-- Ź����, 2018.07.03 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no")); //��� �л��� ������ �ߴ��� �˱����� no���� �Ѱ���
	StudentDao studentDao = new StudentDao();
	Student student = studentDao.selectStudent(studentNo); //��ü���� �޼��带 ������ select������ �̸��� ���̰��� ã��
	
	StudentAddrDao studentAddrDao = new StudentAddrDao();
	StudentAddr studentAddr = studentAddrDao.selectStudentAddr(studentNo); //�ּҰ�ü���� �޼��带 �̿��� select������ �л��ּҸ� ã�� 
%>
<html>
	<head>
		<title>updateStudentForm</title>
	</head>
	<body>
		<!-- ���������� -->
		<form action="<%= request.getContextPath()%>/Student/updateStudentAction.jsp?no=<%=studentNo %>" method="post">
			<fieldset>
				<legend>���� ����</legend>
				<table>
					<tr><!-- �̸� -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>�̸� :&nbsp;</td>
						<td>
							<input type="text" name="studentName" value="<%=student.getStudentName() %>">
						</td>
					</tr>
					<tr><!-- ���� -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>���� :&nbsp;</td>
						<td colspan="3">
							<input type="text" name="studentAge" value="<%=student.getStudentAge() %>">
						</td>
					</tr>
					<tr><!-- �ּ� -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>�ּ� :&nbsp;</td>
						<td colspan="3">
							<input type="text" name="studentAddrContent" size="40" value="<%=studentAddr.getStudentAddrContent() %>">
						</td>
					</tr>
				</table>
			</fieldset><br>
			<fieldset>
				<input type="submit" value="����">
			</fieldset>
		</form>
	</body>
</html>