package com.emerlet.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.emerlet.db.ConnectionProvider;
import com.emerlet.vo.UserToiletReportVO;

public class UserToiletReportDAO {

    public int insertUserReport(UserToiletReportVO vo) {
        int result = 0;
        String sql = "INSERT INTO user_toilet_reports (report_id, user_toilet_id, report_male, report_female, "
                   + "report_male_disabled, report_female_disabled, report_diaper, report_cctv, report_bell, "
                   + "report_description, report_status, reported_at) "
                   + "VALUES (user_toilet_reports_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";

        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, vo.getUserToiletId());
            pstmt.setString(2, vo.getReportMaleToilet());
            pstmt.setString(3, vo.getReportFemaleToilet());
            pstmt.setString(4, vo.getReportMaleDisabledToilet());
            pstmt.setString(5, vo.getReportFemaleDisabledToilet());
            pstmt.setString(6, vo.getReportHasDiaperTable());
            pstmt.setString(7, vo.getReportHasCctv());
            pstmt.setString(8, vo.getReportHasEmergencyBell());
            pstmt.setString(9, vo.getReportDescription());
            pstmt.setString(10, vo.getReportStatus());

            result = pstmt.executeUpdate();
            ConnectionProvider.close(conn, pstmt);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
