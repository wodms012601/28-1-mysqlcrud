<!-- 2018-06-26 28�� �ۿ��� ��1 insert �۾� -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<title>ȸ�� ���� �Է� ������</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>ȸ�� ���� �Է� ������</h1>
		</div>
		<div id="content">
			<!-- ������ ���� Ȯ�ο� �׽�Ʈ �� -->
			<form action="<%= request.getContextPath()%>/Member/insertMemberAction.jsp" method="post">
				<fieldset>
					<legend>���� ����</legend>
					<table>
						<tr><!-- �̸� -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>�̸� :&nbsp;</td>
							<td>
								<input type="text" name="name" id="name" onkeyup="nameCheck()" >
								<span id="nameCheck"></span>
							</td>
						</tr>
						<tr><!-- ���� -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>���� :&nbsp;</td>
							<td>
								<input type="text" name="age" id="age" onkeyup="ageCheck()" >
								<span id="ageCheck"></span>
							</td>
						</tr>
					</table>
				</fieldset><br>
				<fieldset>
					<input type="submit" value="����">
				</fieldset>
			</form>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1�� ������Ʈ  All Rights Reserved.
		</div>
	</body>
</html>