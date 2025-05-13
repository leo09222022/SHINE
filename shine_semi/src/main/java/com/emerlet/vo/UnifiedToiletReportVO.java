// UnifiedToiletReportVO.java
package com.emerlet.vo;

import java.util.Date;

public class UnifiedToiletReportVO {
	private int reportId;
	private String toiletType;
	private int toiletRefId;
	private String reportMale;
	private String reportFemale;
	private String reportMaleDisabled;
	private String reportFemaleDisabled;
	private String reportHasDiaperTable;
	private String reportHasCctv;
	private String reportHasEmergencyBell;
	private String reportDescription;
	private String reportStatus;
	private Date reportedAt; // ✅ 추가됨

	public int getReportId() {
		return reportId;
	}
	public void setReportId(int reportId) {
		this.reportId = reportId;
	}
	public String getToiletType() {
		return toiletType;
	}
	public void setToiletType(String toiletType) {
		this.toiletType = toiletType;
	}
	public int getToiletRefId() {
		return toiletRefId;
	}
	public void setToiletRefId(int toiletRefId) {
		this.toiletRefId = toiletRefId;
	}
	public String getReportMale() {
		return reportMale;
	}
	public void setReportMale(String reportMale) {
		this.reportMale = reportMale;
	}
	public String getReportFemale() {
		return reportFemale;
	}
	public void setReportFemale(String reportFemale) {
		this.reportFemale = reportFemale;
	}
	public String getReportMaleDisabled() {
		return reportMaleDisabled;
	}
	public void setReportMaleDisabled(String reportMaleDisabled) {
		this.reportMaleDisabled = reportMaleDisabled;
	}
	public String getReportFemaleDisabled() {
		return reportFemaleDisabled;
	}
	public void setReportFemaleDisabled(String reportFemaleDisabled) {
		this.reportFemaleDisabled = reportFemaleDisabled;
	}
	public String getReportHasDiaperTable() {
		return reportHasDiaperTable;
	}
	public void setReportHasDiaperTable(String reportHasDiaperTable) {
		this.reportHasDiaperTable = reportHasDiaperTable;
	}
	public String getReportHasCctv() {
		return reportHasCctv;
	}
	public void setReportHasCctv(String reportHasCctv) {
		this.reportHasCctv = reportHasCctv;
	}
	public String getReportHasEmergencyBell() {
		return reportHasEmergencyBell;
	}
	public void setReportHasEmergencyBell(String reportHasEmergencyBell) {
		this.reportHasEmergencyBell = reportHasEmergencyBell;
	}
	public String getReportDescription() {
		return reportDescription;
	}
	public void setReportDescription(String reportDescription) {
		this.reportDescription = reportDescription;
	}
	public String getReportStatus() {
		return reportStatus;
	}
	public void setReportStatus(String reportStatus) {
		this.reportStatus = reportStatus;
	}
	public Date getReportedAt() {
		return reportedAt;
	}
	public void setReportedAt(Date reportedAt) {
		this.reportedAt = reportedAt;
	}
}
