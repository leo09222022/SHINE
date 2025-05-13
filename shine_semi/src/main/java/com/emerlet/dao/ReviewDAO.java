package com.emerlet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ReviewVO;

public class ReviewDAO {

	public ArrayList<ReviewVO> findReview(Integer userToiletId, Integer toiletId) {
		ArrayList<ReviewVO> reviews = new ArrayList<ReviewVO>();

		String sql = "select cleanliness, safety, created_at from reviews where (user_toilet_id = ? and toilet_id is null) or (toilet_id = ? and user_toilet_id is null) order by created_at desc";

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
				review.setCreatedAt(rs.getDate("created_at"));
				reviews.add(review);
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("리뷰 조회 오류 : " + e.getMessage());
			e.printStackTrace();
		}

		return reviews;
	}

	public int insertReview(ReviewVO vo) {
		int result = -1;

		String sql = "insert into reviews (cleanliness,safety,created_at,user_toilet_id, toilet_id) values (?,?,?,?,?)";

		// finally에서 닫기 위해 try-catch 바깥에 생성
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("insertReview 시작 ");
		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, vo.getCleanliness());
			pstmt.setInt(2, vo.getSafety());
			pstmt.setTimestamp(3, new java.sql.Timestamp(vo.getCreatedAt().getTime()));

			// userToiletId랑 toiletId 중 하나만 값이 있고, 다른 하나는 null
			if (vo.getUserToiletId() != 0) {
				pstmt.setObject(4, vo.getUserToiletId());
				pstmt.setNull(5, java.sql.Types.INTEGER);
			} else {
				pstmt.setNull(4, java.sql.Types.INTEGER);
				pstmt.setObject(5, vo.getToiletId());
			}
			result = pstmt.executeUpdate();
			System.out.println("insertReview 종료 ");
		} catch (Exception e) {
			System.out.println("리뷰 조회 오류 : " + e.getMessage());
			e.printStackTrace();
		} finally {
			ConnectionProvider.close(conn, pstmt);
		}

		return result;
	}
	
	public ReviewVO getAvgScoreByToiletId(int toiletId, boolean isUserToilet) {
	    ReviewVO vo = new ReviewVO();

	    String sql;
	    if (isUserToilet) {
	        sql = "SELECT " +
	              "CAST(ROUND(AVG(cleanliness), 0) AS NUMBER) AS avg_cleanliness, " +
	              "CAST(ROUND(AVG(safety), 0) AS NUMBER) AS avg_safety " +
	              "FROM reviews WHERE user_toilet_id = ?";
	    } else {
	        sql = "SELECT " +
	              "CAST(ROUND(AVG(cleanliness), 0) AS NUMBER) AS avg_cleanliness, " +
	              "CAST(ROUND(AVG(safety), 0) AS NUMBER) AS avg_safety " +
	              "FROM reviews WHERE toilet_id = ?";
	    }

	    try (
	        Connection conn = ConnectionProvider.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql)
	    ) {
	        pstmt.setInt(1, toiletId);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            vo.setCleanliness(rs.getInt("avg_cleanliness"));
	            vo.setSafety(rs.getInt("avg_safety"));
	        }
	    } catch (Exception e) {
	        System.out.println("평균 리뷰 조회 중 오류 발생: " + e.getMessage());
	    }

	    return vo;
	}


}

