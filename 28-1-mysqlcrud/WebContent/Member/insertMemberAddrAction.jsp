<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<% request.setCharacterEncoding("UTF-8"); %>
<%
	MemberAddr dao1 = new MemberAddr();
	dao1.setMemberNo(Integer.parseInt(request.getParameter("Member_no")));
	dao1.setMemberAddrContent(request.getParameter("Member_addr_content"));
	
	MemberAddrDao dao = new MemberAddrDao();
	dao.insertMemberAddr(dao1);
	
	response.sendRedirect(request.getContextPath() + "/Member/memberList.jsp");
%>