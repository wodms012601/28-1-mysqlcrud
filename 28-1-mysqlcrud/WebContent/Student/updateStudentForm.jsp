<!-- 탁재은, 2018.07.09 -->
<%@ page language = "java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*" %>
<!DOCTYPE html>
<%
	int studentNo = Integer.parseInt(request.getParameter("no")); //리스트 페이지에서 넘겨받은 학생 번호 데이터를 변수에 저장
	StudentDao studentDao = new StudentDao();
	Student student = studentDao.selectStudent(studentNo); //학생 번호 데이터를 매개변수로 학생 리스트 검색 메서드를 호출, 학생이름과 학생나이가 저장된 학생 객체의 주소값을 리턴받는다.
	
	StudentAddrDao studentAddrDao = new StudentAddrDao();
	//학생 번호 데이터를 매개변수로 학생주소 리스트 검색 메서드를 호출, 학생 주소가 저장된 학생주소 객체의 주소값을 리턴받는다.
	StudentAddr studentAddr = studentAddrDao.selectStudentAddr(studentNo);
%>
<html>
	<head>
		<title>학생 수정 폼</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/main.css">
	</head>
	<body>
		<div id="header">
			<h1>학생 리스트</h1>
		</div>
		<div id="content">
			<!-- 수정페이지 -->
			<form action="<%= request.getContextPath()%>/Student/updateStudentAction.jsp?no=<%=studentNo %>" method="post">
				<fieldset>
					<legend>개인 정보</legend>
					<table>
						<tr><!-- 이름 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>이름 :&nbsp;</td>
							<td>
								<input type="text" name="studentName" value="<%=student.getStudentName() %>" onkeyup="nameCheck()" required>
								<span id="nameSpan"></span>
							</td>
						</tr>
						<tr><!-- 나이 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>나이 :&nbsp;</td>
							<td>
								<input type="text" name="studentAge" value="<%=student.getStudentAge() %>" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required>
								<!-- onkeydown = 키를 눌렀을 때 발생하는 이벤트 / onkeyup = 눌렀던 키를 때면 발생하는 이벤트 -->
								<!-- onkeydown="return showKeyCode(event)" 과 같이 하면 showKeyDown 함수를 호출해서 결과가 true이면 본래의 동작을 그대로 수행하고 false이면 본래의 동작을 중단시킨다 -->
							</td>
						</tr>
						<tr><!-- 주소 -->
							<td><img src="<%=request.getContextPath() %>/image/check_icon.gif"></td>
							<td>주소 :&nbsp;</td>
							<td>
								<input type="text" name="studentAddrContent" size="40" value="<%=studentAddr.getStudentAddrContent() %>" onkeyup="addrCheck()" required>
								<span id="addrSpan"></span>
							</td>
						</tr>
					</table>
				</fieldset><br>
				<fieldset>
					<input type="submit" value="수정">
				</fieldset>
			</form>
		</div>
		<div id="footer">
			COPYRIGHT&copy; 1조 프로젝트  All Rights Reserved.
		</div>
		<script src="<%= request.getContextPath() %>/script/main.js"></script>
	</body>
</html>