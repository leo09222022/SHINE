package com.emerlet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.ReportsPublicToiletVO;

public class ReportsPublicToiletDAO {

	public int insertReport(ReportsPublicToiletVO vo) {
	    int result = 0;
	    String sql = "INSERT INTO Reports_Public_Toilet ("
	            + "report_id, toilet_id, reported_at, "
	            + "report_male_toilet, report_female_toilet, "
	            + "report_male_disabled_toilet, report_female_disabled_toilet, "
	            + "report_has_diaper_table, report_has_emergency_bell, report_has_cctv, "
	            + "report_description, report_photo_error, report_status"
	            + ") VALUES (report_seq.NEXTVAL, ?, SYSDATE, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try {
	        Connection conn = ConnectionProvider.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);

	        pstmt.setInt(1, vo.getToiletId());
	        pstmt.setString(2, vo.getReportMaleToilet());
	        pstmt.setString(3, vo.getReportFemaleToilet());
	        pstmt.setString(4, vo.getReportMaleDisabledToilet());
	        pstmt.setString(5, vo.getReportFemaleDisabledToilet());
	        pstmt.setString(6, vo.getReportHasDiaperTable());
	        pstmt.setString(7, vo.getReportHasEmergencyBell());
	        pstmt.setString(8, vo.getReportHasCctv());
	        pstmt.setString(9, vo.getReportDescription());
	        pstmt.setString(10, vo.getReportPhotoError());   // 기본값 "N" 또는 null 처리 가능
	        pstmt.setString(11, vo.getReportStatus());       // 예: "W" = 대기중

	        result = pstmt.executeUpdate();
	        ConnectionProvider.close(conn, pstmt);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}

}
