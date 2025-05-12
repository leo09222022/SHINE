
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String toiletId = request.getParameter("toilet_id");
  String cleanliness = request.getParameter("cleanliness");
  String safety = request.getParameter("safety");
%>
<p>toiletId: <%= toiletId %></p>
<p>청결도: <%= cleanliness %></p>
<p>안전도: <%= safety %></p>
 