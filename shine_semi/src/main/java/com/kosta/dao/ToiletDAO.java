package com.kosta.dao;

import java.sql.*;
import java.util.*;

import com.kosta.db.ConnectionProvider;
import com.kosta.vo.ToiletVO;

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
	            toilet.setAddress_road(rs.getString("address_road"));
	            toilet.setAddress_lot(rs.getString("address_lot"));
	            toilet.setMale_toilet(rs.getInt("male_toilet"));
	            toilet.setMale_urinal(rs.getInt("male_urinal"));
	            toilet.setMale_disabled_toilet(rs.getInt("male_disabled_toilet"));
	            toilet.setMale_disabled_urinal(rs.getInt("male_disabled_urinal"));
	            toilet.setMale_child_toilet(rs.getInt("male_child_toilet"));
	            toilet.setMale_child_urinal(rs.getInt("male_child_urinal"));
	            toilet.setFemale_toilet(rs.getInt("female_toilet"));
	            toilet.setFemale_disabled_toilet(rs.getInt("female_disabled_toilet"));
	            toilet.setFemale_child_toilet(rs.getInt("female_child_toilet"));
	            toilet.setPhone_number(rs.getString("phone_number"));
	            toilet.setOpen_time_detail(rs.getString("open_time_detail"));
	            toilet.setLat(rs.getDouble("lat"));
	            toilet.setLng(rs.getDouble("lng"));
	            toilet.setHas_emergency_bell(rs.getInt("has_emergency_bell"));
	            toilet.setEmergency_bell_location(rs.getString("emergency_bell_location"));
	            toilet.setHas_cctv(rs.getInt("has_cctv"));
	            toilet.setHas_diaper_table(rs.getInt("has_diaper_table"));
	            toilet.setDiaper_table_location(rs.getString("diaper_table_location"));
	            toilet.setData_reference_date(rs.getDate("data_reference_date"));


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
