package com.emerlet.controller;

import com.emerlet.db.GCPTranslate;
import com.emerlet.db.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletContext;
import java.io.*;
import java.sql.*;
import java.util.Properties;

@WebServlet("/translate")
public class TranslateServlet extends HttpServlet {
    private String apiKey;

    @Override
    public void init() throws ServletException {
        try {
            ServletContext context = getServletContext();
            String fullPath = context.getRealPath("/WEB-INF/shine.properties");
            try (InputStream in = new FileInputStream(fullPath)) {
                Properties props = new Properties();
                props.load(in);
                apiKey = props.getProperty("google_translate_api");
                if (apiKey == null || apiKey.isEmpty()) {
                    throw new ServletException("google_translate_api 키가 shine.properties에 없습니다.");
                }
                GCPTranslate.setApiKey(apiKey); // 전달
            }
        } catch (IOException e) {
            throw new ServletException("API 키 로딩 실패", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int translated = 0;
        try (Connection conn = ConnectionProvider.getConnection()) {
            String sql = "SELECT toilet_id, name FROM toilets WHERE toilet_id NOT IN (SELECT toilet_id FROM foreign_name)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int toiletId = rs.getInt("toilet_id");
                String name = rs.getString("name");
                if (name != null && !name.trim().isEmpty()) {
                    String en = GCPTranslate.translate(name, "en");
                    String ja = GCPTranslate.translate(name, "ja");
                    PreparedStatement insert = conn.prepareStatement("INSERT INTO foreign_name (toilet_id, eng_name, jpn_name) VALUES (?, ?, ?)");
                    insert.setInt(1, toiletId);
                    insert.setString(2, en);
                    insert.setString(3, ja);
                    insert.executeUpdate();
                    translated++;
                }
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("번역 중 오류 발생: " + e.getMessage());
            return;
        }

        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().println("✅ 번역 완료: " + translated + "건 저장됨");
    }
}