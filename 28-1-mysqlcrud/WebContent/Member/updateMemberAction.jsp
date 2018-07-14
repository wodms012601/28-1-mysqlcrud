<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<!DOCTYPE html>

		<% request.setCharacterEncoding("utf-8"); %>
		<%
		
			
			String dbno = request.getParameter("upno");
			String dbname = request.getParameter("upname");
			String dbage = request.getParameter("upage");
			
			MemberDao dao6 = new MemberDao();
			dao6.updateMember(dbname, dbage, dbno);
			
			response.sendRedirect(request.getContextPath() + "/Member/memberList.jsp");
		%>
