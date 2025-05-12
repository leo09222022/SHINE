<%@page import="com.emerlet.db.ConnectionProvider"%>
<%@ page import="java.sql.*, java.text.DecimalFormat" %>
<%@ page contentType="application/json; charset=UTF-8" %>
<%
    String toiletId = request.getParameter("toiletId");
    double cleanliness = 0, safety = 0;
    int count = 0;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = ConnectionProvider.getConnection();

        String sql = "SELECT AVG(cleanliness), AVG(safety) FROM reviews WHERE toilet_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(toiletId));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            cleanliness = rs.getDouble(1);
            safety = rs.getDouble(2);
        }

        // JSON 문자열 직접 출력
        DecimalFormat df = new DecimalFormat("#.#");
        out.print("{");
        out.print("\"cleanliness\": " + df.format(cleanliness) + ", ");
        out.print("\"safety\": " + df.format(safety));
        out.print("}");
    } catch (Exception e) {
        out.print("{\"error\":\"" + e.getMessage().replace("\"", "'") + "\"}");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
