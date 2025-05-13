package com.emerlet.vo;

import java.util.Date;

public class ReportsToiletVO {
	private int reportId;
	private int toiletId;
	private int userToiletId;
	private Date reportedAt;
	private String reportMaleToilet;
	private String reportFemaleToilet;
	private String reportDisabledToilet;
	private String reportHasDiaperTable;
	private String reportDescription;
	private String reportPhotoError;
	private String reportStatus;
	
	// user_toilet 테이블과 조인용
	private String toiletName;
	private String toiletAddress;

	
	
	
	@Override
	public String toString() {
		return "ReportsToiletVO [reportMaleToilet=" + reportMaleToilet + ", reportFemaleToilet=" + reportFemaleToilet
				+ ", reportDisabledToilet=" + reportDisabledToilet + ", reportHasDiaperTable=" + reportHasDiaperTable
				+ ", reportDescription=" + reportDescription + ", reportPhotoError=" + reportPhotoError + "]";
	}

	public ReportsToiletVO() {
		super();
		// TODO Auto-generated constructor stub
	}

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

	public int getUserToiletId() {
		return userToiletId;
	}

	public void setUserToiletId(int userToiletId) {
		this.userToiletId = userToiletId;
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

	public String getReportDisabledToilet() {
		return reportDisabledToilet;
	}

	public void setReportDisabledToilet(String reportDisabledToilet) {
		this.reportDisabledToilet = reportDisabledToilet;
	}

	public String getReportHasDiaperTable() {
		return reportHasDiaperTable;
	}

	public void setReportHasDiaperTable(String reportHasDiaperTable) {
		this.reportHasDiaperTable = reportHasDiaperTable;
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
	
	public String getToiletName() {
		return toiletName;
	}

	public void setToiletName(String toiletName) {
		this.toiletName = toiletName;
	}

	public String getToiletAddress() {
		return toiletAddress;
	}

	public void setToiletAddress(String toiletAddress) {
		this.toiletAddress = toiletAddress;
	}
}
