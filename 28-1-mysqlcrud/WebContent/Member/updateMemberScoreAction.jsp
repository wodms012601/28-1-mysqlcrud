<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<!DOCTYPE html>
<%
	int score = Integer.parseInt(request.getParameter("score"));
	int no = Integer.parseInt(request.getParameter("Member_no"));
	
	MemberScoreDao dao = new MemberScoreDao();
	dao.updateScore(score, no);
	
	response.sendRedirect(request.getContextPath() + "/Member/memberList.jsp?score="+score+"&no="+no);
%>