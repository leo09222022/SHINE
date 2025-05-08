package com.emerlet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ReviewVO;

public class ReviewDAO {

	public ArrayList<ReviewVO> findReview(Integer userToiletId, Integer toiletId) {
		ArrayList<ReviewVO> reviews = new ArrayList<ReviewVO>();

		String sql = "select cleanliness, safety, supplies, createdAt from reviews where (userToiletId = ? and toiletId is null) or (toiletId = ? and userToiletId is null) order by createdAt desc";

		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			// toiletId나 userToiletId가 Null일 수 있기때문에 setInt대신 setObeject 사용
			pstmt.setObject(1, userToiletId);
			pstmt.setObject(2, toiletId);

			ResultSet rs = pstmt.executeQuery();

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

			while (rs.next()) {
				ReviewVO review = new ReviewVO();
				review.setCleanliness(rs.getInt("cleanliness"));
				review.setSafety(rs.getInt("safety"));
				review.setSupplies(rs.getString("supplies"));
				review.setCreatedAt(rs.getTimestamp("createdAt"));
				reviews.add(review);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("리뷰 조회 오류 : " + e.getMessage());
		}

		return reviews;
	}

	public int insertReview(ReviewVO vo) {
		int result = -1;

		String sql = "insert into reviews (cleanliness,safety,supplies,createdAt,userToiletId,toiletId) values (?,?,?,?,?,?)";

		// finally에서 닫기 위해 try-catch 바깥에 생성
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, vo.getCleanliness());
			pstmt.setInt(2, vo.getSafety());
			pstmt.setString(3, vo.getSupplies());
			pstmt.setTimestamp(4, new java.sql.Timestamp(vo.getCreatedAt().getTime()));

			// userToiletId랑 toiletId 중 하나만 값이 있고, 다른 하나는 null
			if (vo.getUserToiletId() != 0) {
				pstmt.setObject(5, vo.getUserToiletId());
				pstmt.setNull(6, java.sql.Types.INTEGER);
			} else {
				pstmt.setNull(5, java.sql.Types.INTEGER);
				pstmt.setObject(6, vo.getToiletId());
			}
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("리뷰 등록 오류 : " + e.getMessage());
		} finally {
			ConnectionProvider.close(conn, pstmt);
		}

		return result;
	}
}
