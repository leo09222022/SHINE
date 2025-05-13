<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%@ page import="com.emerlet.dao.ReviewDAO" %>
<%@ page import="com.emerlet.vo.ReviewVO" %>
<%
    int id = Integer.parseInt(request.getParameter("toiletId"));
    boolean isUser = "Y".equals(request.getParameter("isUser"));

    ReviewDAO dao = new ReviewDAO();
    ReviewVO vo = isUser ? dao.getAvgScoreByToiletId(id, isUser) : dao.getAvgScoreByToiletId(id, isUser);

    out.print("{");
    out.print("\"cleanliness\":" + vo.getCleanliness() + ",");
    out.print("\"safety\":" + vo.getSafety());
    out.print("}");
%>

