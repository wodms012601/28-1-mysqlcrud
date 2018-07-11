<!-- 탁재은, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int employerNo = Integer.parseInt(request.getParameter("no")); //리스트 페이지에서 넘겨받은 고용주 번호 데이터를 변수에 저장
	EmployerDao employerDao = new EmployerDao();
	Employer employer = employerDao.selectEmployer(employerNo); //고용주 번호 데이터를 매개변수로 고용주 리스트 검색 메서드를 호출, 고용주이름과 고용주나이가 저장된 고용주 객체의 주소값을 리턴받는다.
	
	EmployerAddrDao employerAddrDao = new EmployerAddrDao();
	//학생 번호 데이터를 매개변수로 학생주소 리스트 검색 메서드를 호출, 학생 주소가 저장된 학생주소 객체의 주소값을 리턴받는다.
	EmployerAddr employerAddr = employerAddrDao.selectEmployerAddr(employerNo);
%>
<html>
	<head>
		<title>고용주 수정 폼</title>
	</head>
	<body>
		<!-- 데이터 전송 확인용 테스트 폼 -->
		<form action="<%= request.getContextPath()%>/Employer/updateEmployerAction.jsp?no=<%=employerNo %>" method="post">
			<fieldset>
				<legend>개인 정보</legend>
				<table>
					<tr><!-- 이름 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>이름 :&nbsp;</td>
						<td>
							<input type="text" name="employerName" value="<%=employer.getEmployerName() %>">
						</td>
					</tr>
					<tr><!-- 나이 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>나이 :&nbsp;</td>
						<td>
							<input type="text" name="employerAge" size="40" value="<%=employer.getEmployerAge() %>">
						</td>
					</tr>
					<tr><!-- 주소 -->
						<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
						<td>주소 :&nbsp;</td>
						<td>
							<input type="text" name="employerAddrContent" size="40" value="<%=employerAddr.getEmployerAddrContent() %>">
						</td>
					</tr>
				</table>
			</fieldset><br>
			<fieldset>
				<input type="submit" value="가입">
			</fieldset>
		</form>
	</body>
</html>