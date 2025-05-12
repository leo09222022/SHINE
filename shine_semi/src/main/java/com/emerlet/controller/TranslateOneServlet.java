package com.emerlet.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.emerlet.db.GCPTranslate;

@WebServlet("/translateOne")
public class TranslateOneServlet extends HttpServlet {
    private String apiKey;

    @Override
    public void init() throws ServletException {
        try (InputStream in = getServletContext().getResourceAsStream("/WEB-INF/shine.properties")) {
            Properties props = new Properties();
            props.load(in);
            apiKey = props.getProperty("google_translate_api");
        } catch (Exception e) {
            throw new ServletException("API 키 로딩 실패", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String lang = req.getParameter("lang");

        if (lang == null || !(lang.equals("en") || lang.equals("ja"))) lang = "en";

        try {
            String translatedName = GCPTranslate.translate(name, lang, apiKey);
            String translatedAddress = GCPTranslate.translate(address, lang, apiKey);

            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().printf("{\"name\":\"%s\", \"address\":\"%s\"}",
                translatedName.replace("\"", "\\\""),
                translatedAddress.replace("\"", "\\\"")
            );
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().write("{\"error\": \"Translation failed\"}");
        }

    }
}
