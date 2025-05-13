package com.emerlet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ReportsToiletVO;
import com.emerlet.vo.UserToiletVO;

public class ReportsToiletDAO {
	
	public ArrayList<ReportsToiletVO> findByStatus(String status){
		String sql = "select report_id, user_toilets.user_toilet_id, user_name, reported_at "
				+ "from user_toilets, reports_toilet "
				+ "where report_status=? and user_toilets.user_toilet_id=reports_toilet.user_toilet_id "
				+ "order by report_id";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<ReportsToiletVO> result = new ArrayList<ReportsToiletVO>();
		
		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, status);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				ReportsToiletVO vo = new ReportsToiletVO();
				vo.setReportId(rs.getInt(1));
				vo.setUserToiletId(rs.getInt(2));
				vo.setToiletName(rs.getString(3));
				vo.setReportedAt(rs.getDate(4));
				result.add(vo);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionProvider.close(conn, pstmt, rs);
		}

		return result;
	}
	
	public ReportsToiletVO findById(int id) {
		String sql = "select * from reports_toilet where report_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReportsToiletVO result = new ReportsToiletVO();
			
		try {	
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result.setReportId(rs.getInt("report_id"));
				result.setToiletId(rs.getInt("toilet_id"));
				result.setUserToiletId(rs.getInt("user_toilet_id"));
				result.setReportedAt(rs.getDate("reported_at"));
				result.setReportMaleToilet(rs.getString("report_male_toilet"));
				result.setReportFemaleToilet(rs.getString("report_female_toilet"));
				result.setReportDisabledToilet(rs.getString("report_disabled_toilet"));
				result.setReportHasDiaperTable(rs.getString("report_has_diaper_table"));
				result.setReportDescription(rs.getString("report_description"));
				result.setReportPhotoError(rs.getString("report_photo_error"));
				result.setReportStatus(rs.getString("report_status"));
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			ConnectionProvider.close(conn, pstmt, rs);
		}	
			
		return result;
	}
	
	public void updateStatus(int id, String status) {
		System.out.println("updateStatusㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ");
		System.out.println("status: "+status);
		System.out.println("id: "+id);
		
		String sql = "update reports_toilet set report_status=? where report_id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = ConnectionProvider.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, status);
			pstmt.setInt(2, id);
			int re = pstmt.executeUpdate();
			System.out.println("re: "+re);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionProvider.close(conn, pstmt);
		}
	}
}
