package com.emerlet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ToiletVO;
import com.emerlet.vo.ToiletReportsVO;

public class ToiletReportsDAO {

	// 마커 클릭시 얻은 화장실 ID를 가지고 기존의 정보를 불러 오기
	// user_toilet_id일수도 있고 toilet_id일수도 있음
	public ToiletVO findById(Integer toiletId, Integer userToiletId) {
		ToiletVO toilet = null;
		String sql = null;
		boolean isPublic = false;

		if (toiletId != null) {
			sql = "SELECT * FROM toilets WHERE toilet_id = ?";
			isPublic = true;
		} else if (userToiletId != null) {
			sql = "SELECT * FROM user_toilets WHERE user_toilet_id = ?";
		} else {
			return null;
		}

		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, isPublic ? toiletId : userToiletId);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				toilet = new ToiletVO();
				toilet.setName(rs.getString("name"));
				toilet.setAddressRoad(rs.getString("address_road"));
				toilet.setLat(rs.getDouble("lat"));
				toilet.setLng(rs.getDouble("lng"));
				toilet.setMaleToilet(rs.getInt("male_toilet"));
				toilet.setFemaleToilet(rs.getInt("female_toilet"));
				toilet.setMaleDisabledToilet(rs.getInt("male_disabled_toilet"));
				toilet.setFemaleDisabledToilet(rs.getInt("female_disabled_toilet"));
				toilet.setOpenTimeDetail(rs.getString("open_time_detail"));
				toilet.setHasEmergencyBell(rs.getInt("has_emergency_bell"));
				toilet.setHasDiaperTable(rs.getInt("has_diaper_table"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return toilet;
	}


}
