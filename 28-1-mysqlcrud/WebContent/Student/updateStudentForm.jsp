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
						<td>
							<input type="text" name="studentAge" value="<%=student.getStudentAge() %>">
						</td>
					</tr>
					<tr><!-- �ּ� -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>�ּ� :&nbsp;</td>
						<td>
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