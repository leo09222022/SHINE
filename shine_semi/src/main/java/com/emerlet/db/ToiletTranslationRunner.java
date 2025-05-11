package com.emerlet.db;

import java.sql.*;

public class ToiletTranslationRunner {
    public static void main(String[] args) throws Exception {
        Connection conn = ConnectionProvider.getConnection();
        String selectSql = "SELECT toilet_id, name, address_road FROM toilets";
        PreparedStatement ps = conn.prepareStatement(selectSql);
        ResultSet rs = ps.executeQuery();

        int totalCount = 0, insertedName = 0, insertedAddr = 0;

        while (rs.next()) {
            int toiletId = rs.getInt("toilet_id");
            String name = rs.getString("name");
            String roadAddress = rs.getString("address_road");

            totalCount++;

            // 화장실 이름 번역
            if (name != null && !name.trim().isEmpty() && !exists(conn, "foreign_name", toiletId)) {
                String engName = LibreTranslate.translate(name, "en");
                String jpnName = LibreTranslate.translate(name, "ja");
                insertForeignName(conn, toiletId, engName, jpnName);
                insertedName++;
                System.out.println("✅ 이름 번역 완료: " + name);
            }

            // 도로명 주소 번역
            if (roadAddress != null && !roadAddress.trim().isEmpty() && !exists(conn, "foreign_address", toiletId)) {
                String engAddr = LibreTranslate.translate(roadAddress, "en");
                String jpnAddr = LibreTranslate.translate(roadAddress, "ja");
                insertForeignAddress(conn, toiletId, engAddr, jpnAddr);
                insertedAddr++;
                System.out.println("✅ 주소 번역 완료: " + roadAddress);
            }
        }

        rs.close();
        ps.close();
        conn.close();

        System.out.println("\n===== 번역 완료 =====");
        System.out.println("총 조회된 화장실 수: " + totalCount);
        System.out.println("이름 번역 저장 수: " + insertedName);
        System.out.println("주소 번역 저장 수: " + insertedAddr);
    }

    private static boolean exists(Connection conn, String table, int toiletId) throws SQLException {
        String sql = "SELECT 1 FROM " + table + " WHERE toilet_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, toiletId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    private static void insertForeignName(Connection conn, int toiletId, String eng, String jpn) throws SQLException {
        String sql = "INSERT INTO foreign_name (toilet_id, eng_name, jpn_name) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, toiletId);
            ps.setString(2, eng);
            ps.setString(3, jpn);
            ps.executeUpdate();
        }
    }

    private static void insertForeignAddress(Connection conn, int toiletId, String eng, String jpn) throws SQLException {
        String sql = "INSERT INTO foreign_address (toilet_id, eng_addr, jpn_addr) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, toiletId);
            ps.setString(2, eng);
            ps.setString(3, jpn);
            ps.executeUpdate();
        }
    }
}
