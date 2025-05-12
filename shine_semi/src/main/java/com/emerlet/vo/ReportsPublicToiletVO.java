package com.emerlet.vo;

import java.util.Date;

public class ReportsPublicToiletVO {
	private int reportId;
	private int toiletId;
	private Date reportedAt;
	private String reportMaleToilet;
	private String reportFemaleToilet;
	private String reportMaleDisabledToilet;
	private String reportFemaleDisabledToilet;
	private String reportHasDiaperTable;
	private String reportHasEmergencyBell;
	private String reportHasCctv;
	private String reportDescription;
	private String reportPhotoError;
	private String reportStatus;

	public int getReportId() {
		return reportId;
	}

	public void setReportId(int reportId) {
		this.reportId = reportId;
	}

	public int getToiletId() {
		return toiletId;
	}

	public void setToiletId(int toiletId) {
		this.toiletId = toiletId;
	}

	public Date getReportedAt() {
		return reportedAt;
	}

	public void setReportedAt(Date reportedAt) {
		this.reportedAt = reportedAt;
	}

	public String getReportMaleToilet() {
		return reportMaleToilet;
	}

	public void setReportMaleToilet(String reportMaleToilet) {
		this.reportMaleToilet = reportMaleToilet;
	}

	public String getReportFemaleToilet() {
		return reportFemaleToilet;
	}

	public void setReportFemaleToilet(String reportFemaleToilet) {
		this.reportFemaleToilet = reportFemaleToilet;
	}

	public String getReportMaleDisabledToilet() {
		return reportMaleDisabledToilet;
	}

	public void setReportMaleDisabledToilet(String reportMaleDisabledToilet) {
		this.reportMaleDisabledToilet = reportMaleDisabledToilet;
	}

	public String getReportFemaleDisabledToilet() {
		return reportFemaleDisabledToilet;
	}

	public void setReportFemaleDisabledToilet(String reportFemaleDisabledToilet) {
		this.reportFemaleDisabledToilet = reportFemaleDisabledToilet;
	}

	public String getReportHasDiaperTable() {
		return reportHasDiaperTable;
	}

	public void setReportHasDiaperTable(String reportHasDiaperTable) {
		this.reportHasDiaperTable = reportHasDiaperTable;
	}

	public String getReportHasEmergencyBell() {
		return reportHasEmergencyBell;
	}

	public void setReportHasEmergencyBell(String reportHasEmergencyBell) {
		this.reportHasEmergencyBell = reportHasEmergencyBell;
	}

	public String getReportHasCctv() {
		return reportHasCctv;
	}

	public void setReportHasCctv(String reportHasCctv) {
		this.reportHasCctv = reportHasCctv;
	}

	public String getReportDescription() {
		return reportDescription;
	}

	public void setReportDescription(String reportDescription) {
		this.reportDescription = reportDescription;
	}

	public String getReportPhotoError() {
		return reportPhotoError;
	}

	public void setReportPhotoError(String reportPhotoError) {
		this.reportPhotoError = reportPhotoError;
	}

	public String getReportStatus() {
		return reportStatus;
	}

	public void setReportStatus(String reportStatus) {
		this.reportStatus = reportStatus;
	}

	public ReportsPublicToiletVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ReportsPublicToiletVO(int reportId, int toiletId, Date reportedAt, String reportMaleToilet,
			String reportFemaleToilet, String reportMaleDisabledToilet, String reportFemaleDisabledToilet,
			String reportHasDiaperTable, String reportHasEmergencyBell, String reportHasCctv, String reportDescription,
			String reportPhotoError, String reportStatus) {
		super();
		this.reportId = reportId;
		this.toiletId = toiletId;
		this.reportedAt = reportedAt;
		this.reportMaleToilet = reportMaleToilet;
		this.reportFemaleToilet = reportFemaleToilet;
		this.reportMaleDisabledToilet = reportMaleDisabledToilet;
		this.reportFemaleDisabledToilet = reportFemaleDisabledToilet;
		this.reportHasDiaperTable = reportHasDiaperTable;
		this.reportHasEmergencyBell = reportHasEmergencyBell;
		this.reportHasCctv = reportHasCctv;
		this.reportDescription = reportDescription;
		this.reportPhotoError = reportPhotoError;
		this.reportStatus = reportStatus;
	}

}
