<!-- 2018-06-26 28�� �ۿ��� ��1 insert �۾� -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="service.*" %>

<!DOCTYPE html>

<% request.setCharacterEncoding("euc-kr"); %>
<!-- (1) jsp:useBean �� ����� ��� 

<jsp:useBean id="m" class="service.Member"/> ====> Member m = new Member();

<jsp:setProperty name="m" property="member_no" param="no"/>
<jsp:setProperty name="m" property="member_name" param="name"/>
<jsp:setProperty name="m" property="member_age" param="age"/> 
11 ~ 13�� : id�� name�� ���� ���� �Ӽ� �׸��� property�� param �� ������ ������ ���� �ٸ��Ƿ� ���� ���ش�. ���࿡ ���ٸ� property�� ����.

16�� : property(�ڹٺ� Ŭ�����̸�) => private int member_no; ,private String member_name; , private int member_age;
17��~18�� : param(jsp�� name ����) => no, name, age 
		  ex) <input type="text" name="name"(�̰��� param)>
-->


<!-- (2) ���ο� ��ü�����Ͽ� ����� ��� -->

<%	
	Member abc = new Member();
	/*  1. new �����ڰ� abc��ü�� ����� �޷θ� ������ �Ҵ��ϰ�
		2. ������("Member()"")�� abc��ü�� �ʱ�ȭ ��Ų��
		3. new �����ڰ� ���� ������ �ּҸ� ��ü �������� abc�� ������ ����
		4. abc�� ���� Member�� ������ ���������ϴ�.*/
	abc.setMember_name(request.getParameter("name"));
	abc.setMember_age(Integer.parseInt(request.getParameter("age")));
	
	
	
	Memberdao a = new Memberdao();
	a.InsertMember(abc);
	
	response.sendRedirect(request.getContextPath() + "/Member/memberList.jsp");
	
%>