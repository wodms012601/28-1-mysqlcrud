<!-- 2018-06-26 28�� �ۿ��� ��1 insert �۾� -->
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="service.Member" %>
<%@ page import="service.Memberdao" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

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
	/*28�� : abc��ü�������� �ȿ� �ּҰ��� ���� setMember_age �޼ҵ� ���� intŸ�� member_age �Ű�������
			InsertMemberForm.jsp���� ���ڿ��� �Ѱܹ��� age���� ���������� ����ȯ�� �����ش�.*/

	Memberdao a = new Memberdao();
	a.InsertMember(m);
%>