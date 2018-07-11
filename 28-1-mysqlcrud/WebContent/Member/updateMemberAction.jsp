<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="service.*" %>
<!DOCTYPE html>

		<% request.setCharacterEncoding("euc-kr"); %>
		<%
		
			
			String dbno = request.getParameter("upno");
			String dbname = request.getParameter("upname");
			String dbage = request.getParameter("upage");
			
			Memberdao dao6 = new Memberdao();
			dao6.UpdateNumber(dbname, dbage, dbno);
			
			response.sendRedirect(request.getContextPath() + "/Member/memberList.jsp");
		%>
