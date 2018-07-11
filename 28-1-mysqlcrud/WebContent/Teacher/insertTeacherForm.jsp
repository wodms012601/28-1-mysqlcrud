<!-- 28th Choi Yun-Seok, 2018.07.11 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Insert Teacher Addr Form</title>
<style type = "text/css">
	#box {width:300px;}
	#box label {display:black; width:100px; float:left;}

body {
width:800px;
margin:0 auto;
}

#header {
margin:0 0 10px 0;
padding:10px;
border:1px solid #000;
background-color:#DAD9FF;
width:800px;
}

#content {
float:left;
padding:10px;
background-color:#D4F4FA;
border:1px solid #000;
width:800px;
margin-bottom:10px;
}

#sidebar_a {
float:left;
padding:10px;
border:1px solid #000;
width:800px;
background-color:#D9E5FF;
}

#footer {
clear:both;
padding:10px;
border:1px solid #000;
background-color:#E8D9FF;
width:800px;
}
</style>
</head>
<body>
<script>
function onlyNumber(event){ // 오직 숫자만 입력
	event = event || window.event;
	// 다른 브라우저들이 event를 다루는 방법이 서로 다르기 때문에
	// 인수로 전달받은 event가  유효하면 이를 event에 스스로를 다시 한 번 대입하고 브라우저에서 사용할 경우 념겨받은 event가 무효한 경우 window.event로 대신하겠다는 것이다.
	var keyID = (event.which) ? event.which : event.keyCode;
	// event.keyCode 입력된 키의 코드 값을 얻는다.
	// 예를 들어 키보드의 0~9의 숫자는 48~57의 키코드를 가지며, 오른쪽쪽 숫자키 패드의 0~9는 96~105의 키코드를 갖는다.
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
		return;
	else
		return false;
}
function removeChar(event) { // 숫자가 아닌 문자 제거
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
	// 8=Backspace, 46=Delete, 37=왼쪽 화살표, 39=오른쪽 화살표
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
</script>
	<div id="header">
		<h1>Insert Teacher Addr Form</h1>
	</div>

	<div id="sidebar_a">
		<ul>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherList.jsp">선생님 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/selectTeacherAddrList.jsp">주소 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherAndScoreList.jsp">점수 리스트</a></li>
			<li><a href="<%=request.getContextPath() %>/Teacher/teacherListAboveAvg.jsp">평균점수 이상 리스트</a></li>
		</ul>
	</div>

	<div id="content">
		<form action = "<%= request.getContextPath() %>/Teacher/insertTeacherAction.jsp" method="post">
			<fieldset id = "box">
				<legend><h3>Insert Teacher Form</h3></legend>
					<br>
					<br>
					<label for="1">teacherName</label>
					<input type = "text" name = "teacherName" required /> <br/>
				
					<label for="2">teacherAge</label>
					<input type = "text" name = "teacherAge" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' onfocusout='removeChar(event)' required /> <br/> <br/>
					<!-- onkeydown = 키를 눌렀을 때 발생하는 이벤트 / onkeyup = 눌렀던 키를 때면 발생하는 이벤트 -->
					<!-- onkeydown="return showKeyCode(event)" 과 같이 하면 showKeyDown 함수를 호출해서 결과가 true이면 본래의 동작을 그대로 수행하고 false이면 본래의 동작을 중단시킨다 -->
					<input type = "submit" value = "insert">
					<br>
					<br>
			</fieldset>
		</form>
	</div>

	<div id="footer">
		COPYRIGHT(C) 1조 프로젝트 최윤석 All Rights Reserved.
	</div>

</body>
</html>