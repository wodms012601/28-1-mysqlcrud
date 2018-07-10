<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int pagePerRow = 5; //한 페이지당 보는 갯수
	int currentPage = 1; //현재 페이지
	
	if(request.getParameter("currentPage") != null){ //페이지 이동 후 currentPage가 String타입이 되기때문에 int 데이터타입으로 변경
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
%>
<html>
	<head>
		<title>employerList</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th>고용주번호</th>
				<th>고용주이름</th>
				<th>고용주나이</th>
				<th>주소입력</th>
				<th>수정</th>
				<th>삭제</th>
				<th>점수입력</th>
			</tr>
			<tr>
				<td></td>
			</tr>
		</table>
	</body>
</html>