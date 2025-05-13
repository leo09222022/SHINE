package com.emerlet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.UnifiedToiletReportVO;

public class UnifiedToiletReportDAO {
	public int insertReport(UnifiedToiletReportVO vo) {
		int result = 0;
		String sql = "INSERT INTO unified_toilet_reports "
				+ "(report_id, toilet_type, toilet_ref_id, report_male, report_female, "
				+ "report_male_disabled, report_female_disabled, report_diaper, report_cctv, report_bell, "
				+ "report_description, report_status, reported_at) "
				+ "VALUES (unified_toilet_reports_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";

		try (Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, vo.getToiletType());
			pstmt.setInt(2, vo.getToiletRefId());
			pstmt.setString(3, vo.getReportMale());
			pstmt.setString(4, vo.getReportFemale());
			pstmt.setString(5, vo.getReportMaleDisabled());
			pstmt.setString(6, vo.getReportFemaleDisabled());
			pstmt.setString(7, vo.getReportHasDiaperTable());
			pstmt.setString(8, vo.getReportHasCctv());
			pstmt.setString(9, vo.getReportHasEmergencyBell());
			pstmt.setString(10, vo.getReportDescription());
			pstmt.setString(11, vo.getReportStatus());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}
