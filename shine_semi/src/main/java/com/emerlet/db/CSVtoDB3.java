package com.emerlet.db;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.*;

public class CSVtoDB3 {
    public static void main(String[] args) throws Exception {
        Connection conn = ConnectionProvider.getConnection();

        String sql = "insert into toilets (" +
            "name, address_road, address_lot, " +
            "male_toilet, male_urinal, male_disabled_toilet, male_disabled_urinal, " +
            "male_child_toilet, male_child_urinal, " +
            "female_toilet, female_disabled_toilet, female_child_toilet, " +
            "phone_number, open_time_detail, " +
            "lat, lng, " +
            "has_emergency_bell, emergency_bell_location, " +
            "has_cctv, " +
            "has_diaper_table, diaper_table_location, " +
            "data_reference_date" +
        ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement pstmt = conn.prepareStatement(sql);

        BufferedReader br = new BufferedReader(new FileReader("공중화장실.csv"));
        String line;
        int lineNum = 0;

        while ((line = br.readLine()) != null) {
            lineNum++;
            if (lineNum == 1) continue; // 첫 줄(헤더)은 건너뜀

            String[] t = line.split(",", -1);

            try {
                String name = t[3].trim();
                String address_road = t[4].trim();
                String address_lot = t[5].trim();
                String latStr = t[20].trim();
                String lngStr = t[21].trim();

                if (latStr.isEmpty() || lngStr.isEmpty() ||
                    !latStr.matches("-?\\d+(\\.\\d+)?") || !lngStr.matches("-?\\d+(\\.\\d+)?")) {
                    System.err.println("오류 발생 (line " + lineNum + "): 위도/경도 오류");
                    continue;
                }

                double lat = Double.parseDouble(latStr);
                double lng = Double.parseDouble(lngStr);

                pstmt.setString(1, name);                         // 화장실명
                pstmt.setString(2, address_road);                 // 도로명주소
                pstmt.setString(3, address_lot);                  // 지번주소
                pstmt.setInt(4, parseOrZero(t[6]));               // 남자 대변기수
                pstmt.setInt(5, parseOrZero(t[7]));               // 남자 소변기수
                pstmt.setInt(6, parseOrZero(t[8]));               // 남자 장애인 대변기수
                pstmt.setInt(7, parseOrZero(t[9]));               // 남자 장애인 소변기수
                pstmt.setInt(8, parseOrZero(t[10]));              // 남자 어린이 대변기수
                pstmt.setInt(9, parseOrZero(t[11]));              // 남자 어린이 소변기수
                pstmt.setInt(10, parseOrZero(t[12]));             // 여자 대변기수
                pstmt.setInt(11, parseOrZero(t[13]));             // 여자 장애인 대변기수
                pstmt.setInt(12, parseOrZero(t[14]));             // 여자 어린이 대변기수
                pstmt.setString(13, t[16].trim());                // 전화번호
                pstmt.setString(14, t[18].trim());                // 개방시간 상세
                pstmt.setDouble(15, lat);                         // 위도
                pstmt.setDouble(16, lng);                         // 경도
                pstmt.setInt(17, "Y".equalsIgnoreCase(t[25].trim()) ? 1 : 0); // 비상벨 설치 여부
                pstmt.setString(18, t[26].trim());                // 비상벨 설치 장소
                pstmt.setInt(19, "Y".equalsIgnoreCase(t[27].trim()) ? 1 : 0); // CCTV 설치 여부
                pstmt.setInt(20, "Y".equalsIgnoreCase(t[28].trim()) ? 1 : 0); // 기저귀 교환대 유무
                pstmt.setString(21, t[29].trim());                // 기저귀 교환대 위치

                String dateStr = t[31].trim();
                Date dataReferenceDate = null;
                if (!dateStr.isEmpty()) {
                    dataReferenceDate = Date.valueOf(dateStr);
                }
                pstmt.setDate(22, dataReferenceDate);             // 데이터 기준일자

                pstmt.executeUpdate();

            } catch (Exception e) {
                System.err.println("오류 발생 (line " + lineNum + "): " + e.getMessage());
            }
        }

        ConnectionProvider.close(conn, pstmt);
        br.close();

        System.out.println("공중화장실 데이터 삽입 완료!");
    }

    private static int parseOrZero(String value) {
        try {
            return value.trim().isEmpty() ? 0 : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
