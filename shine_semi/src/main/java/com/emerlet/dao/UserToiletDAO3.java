package com.emerlet.dao;

import java.sql.*;
import java.util.ArrayList;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ReportsToiletVO;
import com.emerlet.vo.UserToiletVO;

public class UserToiletDAO3 {
	
	public void updateData(int id, UserToiletVO vo) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;
		try {
			conn = ConnectionProvider.getConnection();
			sql = "update reports_toilet set "
					+ "user_male_toilet=?, " 
					+ "user_female_toilet=?, "
					+ "user_disabled_toilet=?, "
					+ "user_has_diaper_table=?, "
					+ "user_description=?, "
					+ "photo_url=? where "
					+ "user_toilet_id=?";
			
//			pstmt = conn.prepareStatement(sql);
//			
//			pstmt.setInt(1, id);
//			pstmt.executeUpdate();
		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionProvider.close(conn, pstmt);
		}
	}
	
	//update user_toilets set status=? where user_toilet_id=?;
	public void updateStatus(int id, String status) {
		String sql = "update user_toilets set status=? where user_toilet_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, status);
			pstmt.setInt(2, id);
			pstmt.executeUpdate();
			//re = (re >= 1)? status:-1;
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionProvider.close(conn, pstmt);
		}
	}
		
	/*
		String sql = "select user_toilet_id, user_road_address, submitted_at from user_toilets where status=? order by user_toilet_id";
	*/
	public ArrayList<UserToiletVO> findByStatus(String status){
		//String sql = "select user_toilet_id, user_road_address, to_char(submitted_at,'yyyy-mm-dd') from user_toilets where status=? order by user_toilet_id";
		String sql = "select * from user_toilets where status=? order by user_toilet_id";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<UserToiletVO> result = new ArrayList<UserToiletVO>();
			
		try {
			conn = ConnectionProvider.getConnection();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, status);
	        rs = pstmt.executeQuery();
	                     
	        while(rs.next()) {
	            UserToiletVO vo = new UserToiletVO();
	            vo.setUserToiletId(rs.getInt(1));
	            vo.setUserName(rs.getString(2));
	            vo.setUserRoadAddress(rs.getString(3));
	            vo.setUserMaleToilet(rs.getString(4));
	            vo.setUserFemaleToilet(rs.getString(5));
	            vo.setUserMaleDisabledToilet(rs.getString(6));
	            vo.setUserFemaleDisabledToilet(rs.getString(7));
	            vo.setUserHasDiaperTable(rs.getString(8));
	            vo.setUserHasEmergencyBell(rs.getString(9));
	            vo.setUserHasCctv(rs.getString(10));
	            vo.setUserDescription(rs.getString(11));
	            vo.setUserLat(0);
	            vo.setUserLng(0);
	            vo.setSubmittedAt(null);
	            vo.setStatus(status);
	            vo.setPhotoUrl(sql);
	            result.add(vo);
	        }    
	            
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionProvider.close(conn, pstmt, rs);
		}
		
		return result;
	}
		
	public UserToiletVO findById(int id) {
		String sql = "select * from user_toilets where user_toilet_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserToiletVO result = new UserToiletVO();
			
		try {	
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result.setUserToiletId(rs.getInt(1));
				result.setUserName(rs.getString(2));
				result.setUserRoadAddress(rs.getString(3));
				result.setUserMaleToilet(rs.getString(4));
				result.setUserFemaleToilet(rs.getString(5));
				result.setUserDisabledToilet(rs.getString(6));
				result.setUserHasDiaperTable(rs.getString(7));
				result.setUserDescription(rs.getString(8));
				result.setUserLat(rs.getDouble(9));
				result.setUserLng(rs.getDouble(10));
				result.setSubmittedAt(rs.getDate(11));
				result.setStatus(rs.getString(12));
				result.setPhotoUrl(rs.getString(13));
				//result.setUserEditRequest(rs.getString(14).charAt(0));
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			ConnectionProvider.close(conn, pstmt, rs);
		}	
			
		return result;
	}

    // 화장실 추가하고 생성된 ID 반환
    public int addUserToilet(UserToiletVO userToilet) {
        String sql = "INSERT INTO user_toilets (user_toilet_id, user_name, user_road_address, "
                + "user_male_toilet, user_female_toilet, user_disabled_toilet, user_has_diaper_table, "
                + "user_description, user_lat, user_lng, submitted_at, status, photo_url) "
                + "VALUES (user_toilet_id_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, 'pending', ?)";
        
        String[] generatedColumns = {"user_toilet_id"}; // 자동 생성되는 키 컬럼 이름
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int newId = -1;  // 실패 시 -1 반환

        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql, generatedColumns);

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
            
            if (result > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    newId = rs.getInt(1);
                    System.out.println("생성된 화장실 ID: " + newId);
                }
            }
            
            return newId;

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            ConnectionProvider.close(conn, pstmt, rs);
        }
    }
}