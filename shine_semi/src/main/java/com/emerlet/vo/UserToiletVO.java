package com.emerlet.vo;

import java.util.Date;

public class UserToiletVO {
	private int userToiletId;
	private String userName;
	private String userRoadAddress;
	private String userMaleToilet;
	private String userFemaleToilet;
	private String userMaleDisabledToilet;
	private String userHasDiaperTable;
	private String userDescription;
	private double userLat;
	private double userLng;
	private Date submittedAt;
	private String status;
	private String photoUrl;
	private String userFemaleDisabledToilet;
	private String userHasEmergencyBell;
	private String userHasCctv;

	public UserToiletVO() {
	}

	// Getters and Setters
	public int getUserToiletId() {
		return userToiletId;
	}

	public void setUserToiletId(int userToiletId) {
		this.userToiletId = userToiletId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserRoadAddress() {
		return userRoadAddress;
	}

	public void setUserRoadAddress(String userRoadAddress) {
		this.userRoadAddress = userRoadAddress;
	}

	public String getUserMaleToilet() {
		return userMaleToilet;
	}

	public void setUserMaleToilet(String userMaleToilet) {
		this.userMaleToilet = userMaleToilet;
	}

	public String getUserFemaleToilet() {
		return userFemaleToilet;
	}

	public void setUserFemaleToilet(String userFemaleToilet) {
		this.userFemaleToilet = userFemaleToilet;
	}

	public String getUserMaleDisabledToilet() {
		return userMaleDisabledToilet;
	}

	public void setUserMaleDisabledToilet(String userMaleDisabledToilet) {
		this.userMaleDisabledToilet = userMaleDisabledToilet;
	}

	public String getUserHasDiaperTable() {
		return userHasDiaperTable;
	}

	public void setUserHasDiaperTable(String userHasDiaperTable) {
		this.userHasDiaperTable = userHasDiaperTable;
	}

	public String getUserDescription() {
		return userDescription;
	}

	public void setUserDescription(String userDescription) {
		this.userDescription = userDescription;
	}

	public double getUserLat() {
		return userLat;
	}

	public void setUserLat(double userLat) {
		this.userLat = userLat;
	}

	public double getUserLng() {
		return userLng;
	}

	public void setUserLng(double userLng) {
		this.userLng = userLng;
	}

	public Date getSubmittedAt() {
		return submittedAt;
	}

	public void setSubmittedAt(Date submittedAt) {
		this.submittedAt = submittedAt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}
	
	public String getUserFemaleDisabledToilet() { return userFemaleDisabledToilet; }
	public void setUserFemaleDisabledToilet(String val) { this.userFemaleDisabledToilet = val; }

	public String getUserHasEmergencyBell() { return userHasEmergencyBell; }
	public void setUserHasEmergencyBell(String val) { this.userHasEmergencyBell = val; }

	public String getUserHasCctv() { return userHasCctv; }
	public void setUserHasCctv(String val) { this.userHasCctv = val; }
}