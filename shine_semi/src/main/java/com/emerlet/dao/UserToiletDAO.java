package com.emerlet.dao;

import java.sql.*;
import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.UserToiletVO;

public class UserToiletDAO {

	public boolean addUserToilet(UserToiletVO userToilet) {
		String sql = "INSERT INTO user_toilets (user_toilet_id, user_name, user_road_address, "
				+ "user_male_toilet, user_female_toilet, user_disabled_toilet, user_has_diaper_table, "
				+ "user_description, user_lat, user_lng, submitted_at, status, photo_url) "
				+ "VALUES (user_toilet_id_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, 'pending', ?)";
		// status의 값은 기본 'pending'
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userToilet.getUserName());
			pstmt.setString(2, userToilet.getUserRoadAddress());

			// null 처리 - "모름" 일 경우 null 설정
			if (userToilet.getUserMaleToilet() == null) {
				pstmt.setNull(3, Types.CHAR);
			} else {
				pstmt.setString(3, userToilet.getUserMaleToilet());
			}

			if (userToilet.getUserFemaleToilet() == null) {
				pstmt.setNull(4, Types.CHAR);
			} else {
				pstmt.setString(4, userToilet.getUserFemaleToilet());
			}

			if (userToilet.getUserDisabledToilet() == null) {
				pstmt.setNull(5, Types.CHAR);
			} else {
				pstmt.setString(5, userToilet.getUserDisabledToilet());
			}

			if (userToilet.getUserHasDiaperTable() == null) {
				pstmt.setNull(6, Types.CHAR);
			} else {
				pstmt.setString(6, userToilet.getUserHasDiaperTable());
			}

			pstmt.setString(7, userToilet.getUserDescription());
			pstmt.setDouble(8, userToilet.getUserLat());
			pstmt.setDouble(9, userToilet.getUserLng());
			pstmt.setString(10, userToilet.getPhotoUrl());

			System.out.println("SQL 실행: " + sql);
			System.out.println("파라미터: name=" + userToilet.getUserName() + ", maleToilet="
					+ userToilet.getUserMaleToilet() + ", femaleToilet=" + userToilet.getUserFemaleToilet()
					+ ", disabledToilet=" + userToilet.getUserDisabledToilet() + ", hasDiaperTable="
					+ userToilet.getUserHasDiaperTable());

			int result = pstmt.executeUpdate();
			return result > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionProvider.close(conn, pstmt);
		}
	}
}