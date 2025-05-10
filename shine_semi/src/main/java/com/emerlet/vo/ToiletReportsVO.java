package com.emerlet.vo;

import java.sql.Date;

public class ToiletReportsVO {
	private int report_id;
	private int toilet_id; 
	private int user_toilet_id;
	
	private Date reportedAt;

	private String reportMaleToilet;
	private String reportFemaleToilet; 
	private String reportDisabledToilet; 
	private String reportHasDiaperTable; 

	private String reportDescription; 
	private String reportPhotoError; 
	private String reportStatus;
	
	public ToiletReportsVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ToiletReportsVO(int report_id, int toilet_id, int user_toilet_id, Date reportedAt, String reportMaleToilet,
			String reportFemaleToilet, String reportDisabledToilet, String reportHasDiaperTable,
			String reportDescription, String reportPhotoError, String reportStatus) {
		super();
		this.report_id = report_id;
		this.toilet_id = toilet_id;
		this.user_toilet_id = user_toilet_id;
		this.reportedAt = reportedAt;
		this.reportMaleToilet = reportMaleToilet;
		this.reportFemaleToilet = reportFemaleToilet;
		this.reportDisabledToilet = reportDisabledToilet;
		this.reportHasDiaperTable = reportHasDiaperTable;
		this.reportDescription = reportDescription;
		this.reportPhotoError = reportPhotoError;
		this.reportStatus = reportStatus;
	}

	public int getReport_id() {
		return report_id;
	}

	public void setReport_id(int report_id) {
		this.report_id = report_id;
	}

	public int getToilet_id() {
		return toilet_id;
	}

	public void setToilet_id(int toilet_id) {
		this.toilet_id = toilet_id;
	}

	public int getUser_toilet_id() {
		return user_toilet_id;
	}

	public void setUser_toilet_id(int user_toilet_id) {
		this.user_toilet_id = user_toilet_id;
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

	
	
	
	
}