<!-- Ź����, 2018.07.09 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no")); //����Ʈ ���������� �Ѱܹ��� �л� ��ȣ �����͸� ������ ����
	StudentDao studentDao = new StudentDao();
	Student student = studentDao.selectStudent(studentNo); //�л� ��ȣ �����͸� �Ű������� �л� ����Ʈ �˻� �޼��带 ȣ��, �л��̸��� �л����̰� ����� �л� ��ü�� �ּҰ��� ���Ϲ޴´�.
	
	StudentAddrDao studentAddrDao = new StudentAddrDao();
	//�л� ��ȣ �����͸� �Ű������� �л��ּ� ����Ʈ �˻� �޼��带 ȣ��, �л� �ּҰ� ����� �л��ּ� ��ü�� �ּҰ��� ���Ϲ޴´�.
	StudentAddr studentAddr = studentAddrDao.selectStudentAddr(studentNo);
%>
<html>
	<head>
		<title>�л� ���� ��</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>�л� ����Ʈ</h1>
		</div>
		<div id="content">
			<!-- ���������� -->
			<form action="<%= request.getContextPath()%>/Student/updateStudentAction.jsp?no=<%=studentNo %>" method="post">
				<fieldset>
					<legend>���� ����</legend>
					<table>
						<tr><!-- �̸� -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>�̸� :&nbsp;</td>
							<td>
								<input type="text" name="studentName" value="<%=student.getStudentName() %>" onkeyup="nameCheck()" required>
								<span id="nameSpan"></span>
							</td>
						</tr>
						<tr><!-- ���� -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>���� :&nbsp;</td>
							<td>
								<input type="text" name="studentAge" value="<%=student.getStudentAge() %>" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required>
								<!-- onkeydown = Ű�� ������ �� �߻��ϴ� �̺�Ʈ / onkeyup = ������ Ű�� ���� �߻��ϴ� �̺�Ʈ -->
								<!-- onkeydown="return showKeyCode(event)" �� ���� �ϸ� showKeyDown �Լ��� ȣ���ؼ� ����� true�̸� ������ ������ �״�� �����ϰ� false�̸� ������ ������ �ߴܽ�Ų�� -->
							</td>
						</tr>
						<tr><!-- �ּ� -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>�ּ� :&nbsp;</td>
							<td>
								<input type="text" name="studentAddrContent" size="40" value="<%=studentAddr.getStudentAddrContent() %>" onkeyup="addrCheck()" required>
								<span id="addrSpan"></span>
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
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>