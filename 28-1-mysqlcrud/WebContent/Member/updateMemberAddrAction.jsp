<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import = "service.*"  %>
<!DOCTYPE html>
<%
	//UTF-8�� ���ڵ�
	request.setCharacterEncoding("UTF-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo")); //������ ���������� �Ѱܹ��� ȸ����ȣ �����͸� ������ ����
	String memberAddrContent = request.getParameter("memberAddrContent"); //������ ���������� �Ѱܹ��� ȸ���ּ� �����͸� ������ ����
	
	//ȸ���ּ� ��ü ���� �� set�޼ҵ带 ���� ������ ����
	MemberAddr memberAddr = new MemberAddr();
	memberAddr.setMemberNo(memberNo);
	memberAddr.setMemberAddrContent(memberAddrContent);
	System.out.println("ȸ���ּ� ���� �Ϸ�");
		
	//ȸ���ּ� ���̺� ����
	MemberAddrDao memberAddrDao = new MemberAddrDao();
	memberAddrDao.updateMemberAddr(memberAddr); //�л���ȣ�� �л��ּ� �����Ͱ� ����� �л��ּ� ��ü�� �ּҰ��� �Ű������� ����
	
	response.sendRedirect(request.getContextPath()+"/Member/memberList.jsp"); //��� ó���� ������ ����Ʈ�������� �̵�
%>