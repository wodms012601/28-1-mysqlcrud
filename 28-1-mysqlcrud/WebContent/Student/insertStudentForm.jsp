<!-- Ź����, 2018.06.26 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<title>insertStudentForm</title>
	</head>
	<body>
		<!-- ������ ���� Ȯ�ο� �׽�Ʈ �� -->
		<form action="<%= request.getContextPath()%>/Student/insertStudentAction.jsp" method="post">
			<fieldset>
				<legend>���� ����</legend>
				<table>
					<tr><!-- �̸� -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>�̸� :&nbsp;</td>
						<td>
							<input type="text" name="studentName">
						</td>
					</tr>
					<tr><!-- ���� -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>���� :&nbsp;</td>
						<td colspan="3">
							<input type="text" name="studentAge">
						</td>
					</tr>
					<tr><!-- �ּ� -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>�ּ� :&nbsp;</td>
						<td colspan="3">
							<input type="text" name="studentAddrContent" size="40">
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