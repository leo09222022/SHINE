package com.emerlet.dao;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ToiletVO;

import java.io.BufferedReader;
import java.io.FileReader;


public class ToiletDAO {

	public void setupDB(String csvPath) {
	    try (Connection conn = ConnectionProvider.getConnection()) {
	        String sqlCheck = "SELECT COUNT(*) FROM toilets";
	        Statement stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery(sqlCheck);

	        if (rs.next()) {
	            int count = rs.getInt(1);
	            if (count > 0) {
	                System.out.println("초기데이터 체크 완료 (이미 데이터 존재)");
	                return;
	            }
	        }

	        System.out.println("데이터가 없어 CSV에서 삽입을 시작합니다.");

	        // INSERT 로직만 유지
	        String sql = "INSERT INTO toilets ("
	                + "name, address_road, address_lot, male_toilet, male_urinal, male_disabled_toilet,"
	                + "male_disabled_urinal, male_child_toilet, male_child_urinal, female_toilet,"
	                + "female_disabled_toilet, female_child_toilet, phone_number, open_time_detail, lat, lng,"
	                + "has_emergency_bell, emergency_bell_location, has_cctv, has_diaper_table, diaper_table_location,"
	                + "data_reference_date) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        BufferedReader br = new BufferedReader(new FileReader(csvPath));
	        String line;
	        int lineNum = 0;

	        while ((line = br.readLine()) != null) {
	            lineNum++;
	            if (lineNum == 1) continue; // Skip header

	            String[] t = line.split(",", -1);
	            try {
	                String name = t[3].trim();
	                String address_road = t[4].trim();
	                String address_lot = t[5].trim();
	                String latStr = t[20].trim();
	                String lngStr = t[21].trim();

	                if (latStr.isEmpty() || lngStr.isEmpty() ||
	                    !latStr.matches("-?\\d+(\\.\\d+)?") || !lngStr.matches("-?\\d+(\\.\\d+)?")) {
	                    continue;
	                }

	                double lat = Double.parseDouble(latStr);
	                double lng = Double.parseDouble(lngStr);

	                pstmt.setString(1, name);
	                pstmt.setString(2, address_road);
	                pstmt.setString(3, address_lot);
	                pstmt.setInt(4, parseOrZero(t[6]));
	                pstmt.setInt(5, parseOrZero(t[7]));
	                pstmt.setInt(6, parseOrZero(t[8]));
	                pstmt.setInt(7, parseOrZero(t[9]));
	                pstmt.setInt(8, parseOrZero(t[10]));
	                pstmt.setInt(9, parseOrZero(t[11]));
	                pstmt.setInt(10, parseOrZero(t[12]));
	                pstmt.setInt(11, parseOrZero(t[13]));
	                pstmt.setInt(12, parseOrZero(t[14]));
	                pstmt.setString(13, t[16].trim());
	                pstmt.setString(14, t[18].trim());
	                pstmt.setDouble(15, lat);
	                pstmt.setDouble(16, lng);
	                pstmt.setInt(17, "Y".equalsIgnoreCase(t[25].trim()) ? 1 : 0);
	                pstmt.setString(18, t[26].trim());
	                pstmt.setInt(19, "Y".equalsIgnoreCase(t[27].trim()) ? 1 : 0);
	                pstmt.setInt(20, "Y".equalsIgnoreCase(t[28].trim()) ? 1 : 0);
	                pstmt.setString(21, t[29].trim());

	                String dateStr = t[31].trim();
	                Date refDate = null;
	                if (!dateStr.isEmpty()) {
	                    refDate = Date.valueOf(dateStr);
	                }
	                pstmt.setDate(22, refDate);

	                pstmt.executeUpdate();
	            } catch (Exception e) {
	                System.err.println("데이터 삽입 중: " + lineNum + ": " + e.getMessage());
	            }
	        }

	        br.close();
	        System.out.println("CSV 데이터를 정상 삽입 완료했습니다.");

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


    private int parseOrZero(String value) {
        try {
            return value.trim().isEmpty() ? 0 : Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }
    
    
    public ArrayList<ToiletVO> findAll() {
	    ArrayList<ToiletVO> toilets = new ArrayList<>();

	    String sql = "SELECT toilet_id, name, address_road, address_lot, " +
	               "male_toilet, male_urinal, male_disabled_toilet, male_disabled_urinal, " +
	               "male_child_toilet, male_child_urinal, " +
	               "female_toilet, female_disabled_toilet, female_child_toilet, " +
	               "phone_number, open_time_detail, " +
	               "lat, lng, " +
	               "has_emergency_bell, emergency_bell_location, " +
	               "has_cctv, has_diaper_table, diaper_table_location, data_reference_date " +
	               "FROM toilets";

	    try (Connection conn = ConnectionProvider.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         ResultSet rs = pstmt.executeQuery()) {

	        while (rs.next()) {
	            ToiletVO toilet = new ToiletVO();
	            toilet.setToiletId(rs.getInt("toilet_id"));
	            toilet.setName(rs.getString("name"));
	            toilet.setAddressRoad(rs.getString("address_road"));
	            toilet.setAddressLot(rs.getString("address_lot"));
	            toilet.setMaleToilet(rs.getInt("male_toilet"));
	            toilet.setMaleUrinal(rs.getInt("male_urinal"));
	            toilet.setMaleDisabledToilet(rs.getInt("male_disabled_toilet"));
	            toilet.setMaleDisabledUrinal(rs.getInt("male_disabled_urinal"));
	            toilet.setMaleChildToilet(rs.getInt("male_child_toilet"));
	            toilet.setMaleChildUrinal(rs.getInt("male_child_urinal"));
	            toilet.setFemaleToilet(rs.getInt("female_toilet"));
	            toilet.setFemaleDisabledToilet(rs.getInt("female_disabled_toilet"));
	            toilet.setFemaleChildToilet(rs.getInt("female_child_toilet"));
	            toilet.setPhoneNumber(rs.getString("phone_number"));
	            toilet.setOpenTimeDetail(rs.getString("open_time_detail"));
	            toilet.setLat(rs.getDouble("lat"));
	            toilet.setLng(rs.getDouble("lng"));
	            toilet.setHasEmergencyBell(rs.getInt("has_emergency_bell"));
	            toilet.setEmergencyBellLocation(rs.getString("emergency_bell_location"));
	            toilet.setHasCctv(rs.getInt("has_cctv"));
	            toilet.setHasDiaperTable(rs.getInt("has_diaper_table"));
	            toilet.setDiaperTableLocation(rs.getString("diaper_table_location"));
	            toilet.setDataReferenceDate(rs.getDate("data_reference_date"));

	            toilets.add(toilet);
	        }

	        System.out.println("DAO 실행됨");
	        System.out.println("총 개수: " + toilets.size());
	        ConnectionProvider.close(conn, pstmt, rs);

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return toilets;
	}
    
    public ArrayList<ToiletVO> searchByRoadAddress(String keyword) {
        ArrayList<ToiletVO> toilets = new ArrayList<>();
        
        String sql = "SELECT name, address_road, address_lot, " +
                    "male_toilet, male_urinal, male_disabled_toilet, male_disabled_urinal, " +
                    "male_child_toilet, male_child_urinal, " +
                    "female_toilet, female_disabled_toilet, female_child_toilet, " +
                    "phone_number, open_time_detail, " +
                    "lat, lng, " +
                    "has_emergency_bell, emergency_bell_location, " +
                    "has_cctv, has_diaper_table, diaper_table_location, data_reference_date " +
                    "FROM toilets WHERE UPPER(address_road) LIKE UPPER(?)";
        
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + keyword + "%");
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ToiletVO toilet = new ToiletVO();
                    toilet.setName(rs.getString("name"));
                    toilet.setAddressRoad(rs.getString("address_road"));
                    toilet.setAddressLot(rs.getString("address_lot"));
                    toilet.setMaleToilet(rs.getInt("male_toilet"));
                    toilet.setMaleUrinal(rs.getInt("male_urinal"));
                    toilet.setMaleDisabledToilet(rs.getInt("male_disabled_toilet"));
                    toilet.setMaleDisabledUrinal(rs.getInt("male_disabled_urinal"));
                    toilet.setMaleChildToilet(rs.getInt("male_child_toilet"));
                    toilet.setMaleChildUrinal(rs.getInt("male_child_urinal"));
                    toilet.setFemaleToilet(rs.getInt("female_toilet"));
                    toilet.setFemaleDisabledToilet(rs.getInt("female_disabled_toilet"));
                    toilet.setFemaleChildToilet(rs.getInt("female_child_toilet"));
                    toilet.setPhoneNumber(rs.getString("phone_number"));
                    toilet.setOpenTimeDetail(rs.getString("open_time_detail"));
                    toilet.setLat(rs.getDouble("lat"));
                    toilet.setLng(rs.getDouble("lng"));
                    toilet.setHasEmergencyBell(rs.getInt("has_emergency_bell"));
                    toilet.setEmergencyBellLocation(rs.getString("emergency_bell_location"));
                    toilet.setHasCctv(rs.getInt("has_cctv"));
                    toilet.setHasDiaperTable(rs.getInt("has_diaper_table"));
                    toilet.setDiaperTableLocation(rs.getString("diaper_table_location"));
                    toilet.setDataReferenceDate(rs.getDate("data_reference_date"));
                    
                    toilets.add(toilet);
                }
            }
            
            System.out.println("검색 결과: " + toilets.size() + "개의 화장실");
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return toilets;
    }
    
    
    public ToiletVO findByID(int id) {
        ToiletVO vo = new ToiletVO();
        String SQL = "SELECT * FROM toilets WHERE toilet_id = ?";

        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, id);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                vo.setToiletId(rs.getInt("toilet_id"));
                vo.setName(rs.getString("name"));
                vo.setAddressRoad(rs.getString("address_road"));
                vo.setAddressLot(rs.getString("address_lot"));
                vo.setLat(rs.getDouble("lat"));
                vo.setLng(rs.getDouble("lng"));
                vo.setMaleToilet(rs.getInt("male_toilet"));
                vo.setMaleUrinal(rs.getInt("male_urinal"));
                vo.setMaleDisabledToilet(rs.getInt("male_disabled_toilet"));
                vo.setMaleDisabledUrinal(rs.getInt("male_disabled_urinal"));
                vo.setMaleChildToilet(rs.getInt("male_child_toilet"));
                vo.setMaleChildUrinal(rs.getInt("male_child_urinal"));
                vo.setFemaleToilet(rs.getInt("female_toilet"));
                vo.setFemaleDisabledToilet(rs.getInt("female_disabled_toilet"));
                vo.setFemaleChildToilet(rs.getInt("female_child_toilet"));
                vo.setPhoneNumber(rs.getString("phone_number"));
                vo.setOpenTimeDetail(rs.getString("open_time_detail"));
                vo.setHasEmergencyBell(rs.getInt("has_emergency_bell"));
                vo.setEmergencyBellLocation(rs.getString("emergency_bell_location"));
                vo.setHasCctv(rs.getInt("has_cctv"));
                vo.setHasDiaperTable(rs.getInt("has_diaper_table"));
                vo.setDiaperTableLocation(rs.getString("diaper_table_location"));
                vo.setDataReferenceDate(rs.getDate("data_reference_date")); // java.sql.Date → java.util.Date 자동 형변환 가능
            }

            ConnectionProvider.close(conn, pstmt, rs);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return vo;
    }

}



