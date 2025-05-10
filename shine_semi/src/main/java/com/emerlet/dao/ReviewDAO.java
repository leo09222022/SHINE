package com.emerlet.dao;

import java.sql.*;
import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ReviewVO;

public class ReviewDAO {

	public boolean addReview(ReviewVO review, boolean isUserToilet) {
		String sql = "INSERT INTO reviews (review_id, cleanliness, safety, accessibility, supplies, created_at, "
				+ (isUserToilet ? "user_toilet_id" : "toilet_id") + ") "
				+ "VALUES (review_id_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, review.getCleanliness());
			pstmt.setInt(2, review.getSafety());
			pstmt.setInt(3, review.getAccessibility());
			pstmt.setInt(4, review.getSupplies());

			if (isUserToilet) {
				pstmt.setInt(5, review.getUserToiletId());
			} else {
				pstmt.setInt(5, review.getToiletId());
			}

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