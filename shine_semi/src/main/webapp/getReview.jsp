<%@ page language="java" contentType="application/json; charset=UTF-8" %>
<%@ page import="com.emerlet.dao.ReviewDAO" %>
<%@ page import="com.emerlet.vo.ReviewVO" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    int id = Integer.parseInt(request.getParameter("toiletId"));
    boolean isUser = "Y".equals(request.getParameter("isUser"));

    ReviewDAO dao = new ReviewDAO();
    ReviewVO vo = dao.getAvgScoreByToiletId(id, isUser);

    // 소수점 1자리까지 포맷
    DecimalFormat df = new DecimalFormat("#.#");
    String avgCleanliness = df.format(vo.getCleanliness());
    String avgSafety = df.format(vo.getSafety());

    out.print("{");
    out.print("\"cleanliness\":" + avgCleanliness + ",");
    out.print("\"safety\":" + avgSafety);
    out.print("}");
%>
