<!-- 2018-06-26 28기 송원민 모델1 insert 작업 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>

<!DOCTYPE html>

<% request.setCharacterEncoding("utf-8"); %>
<!-- (1) jsp:useBean 을 사용한 방식 

<jsp:useBean id="m" class="service.Member"/> ====> Member m = new Member();

<jsp:setProperty name="m" property="member_no" param="no"/>
<jsp:setProperty name="m" property="member_name" param="name"/>
<jsp:setProperty name="m" property="member_age" param="age"/> 
11 ~ 13행 : id와 name은 서로 같은 속성 그리고 property와 param 의 저장할 값들이 서로 다르므로 따로 써준다. 만약에 같다면 property만 쓴다.

16행 : property(자바빈 클래스이름) => private int member_no; ,private String member_name; , private int member_age;
17행~18행 : param(jsp의 name 값들) => no, name, age 
		  ex) <input type="text" name="name"(이값이 param)>
-->


<!-- (2) 새로운 객체생성하여 사용한 방식 -->

<%	
	Member abc = new Member();
	/*  1. new 연산자가 abc객체에 저장될 메로리 공간에 할당하고
		2. 생성자("Member()"")가 abc객체를 초기화 시킨다
		3. new 연산자가 새로 생성된 주소를 객체 참조변수 abc에 변수에 저장
		4. abc를 통해 Member에 접근이 가능해집니다.*/
	abc.setMember_name(request.getParameter("name"));
	abc.setMember_age(Integer.parseInt(request.getParameter("age")));
	
	
	
	Memberdao a = new Memberdao();
	a.insertMember(abc);
	
	response.sendRedirect(request.getContextPath() + "/Member/memberList.jsp");
	
%>