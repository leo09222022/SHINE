package com.emerlet.dao;

import java.sql.*;
import java.util.*;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ToiletVO;

public class ToiletDAO {

	public ArrayList<ToiletVO> findAll() {
	    ArrayList<ToiletVO> toilets = new ArrayList<>();

	    String sql = "SELECT name, address_road, address_lot, " +
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
}
