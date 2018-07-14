<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8로 인코딩
	request.setCharacterEncoding("UTF-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo")); //수정폼 페이지에서 넘겨받은 회원번호 데이터를 변수에 저장
	String memberAddrContent = request.getParameter("memberAddrContent"); //수정폼 페이지에서 넘겨받은 회원주소 데이터를 변수에 저장
	
	//회원주소 객체 생성 및 set메소드를 통해 데이터 삽입
	MemberAddr memberAddr = new MemberAddr();
	memberAddr.setMemberNo(memberNo);
	memberAddr.setMemberAddrContent(memberAddrContent);
	System.out.println("회원주소 수정 완료");
		
	//회원주소 테이블에 수정
	MemberAddrDao memberAddrDao = new MemberAddrDao();
	memberAddrDao.updateMemberAddr(memberAddr); //학생번호와 학생주소 데이터가 저장된 학생주소 객체의 주소값을 매개변수로 대입
	
	response.sendRedirect(request.getContextPath()+"/Member/memberList.jsp"); //모든 처리가 끝나면 리스트페이지로 이동
%>