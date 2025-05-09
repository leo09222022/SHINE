package com.emerlet.vo;

import java.util.Date;

public class ReviewVO {
	private int reviewId;
	private int cleanliness;
	private int safety;
	private int accessibility;
	private int supplies;
	private Date createdAt;
	private int userToiletId;
	private int toiletId;

	public ReviewVO() {
	}

	// Getters and Setters
	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public int getCleanliness() {
		return cleanliness;
	}

	public void setCleanliness(int cleanliness) {
		this.cleanliness = cleanliness;
	}

	public int getSafety() {
		return safety;
	}

	public void setSafety(int safety) {
		this.safety = safety;
	}

	public int getAccessibility() {
		return accessibility;
	}

	public void setAccessibility(int accessibility) {
		this.accessibility = accessibility;
	}

	public int getSupplies() {
		return supplies;
	}

	public void setSupplies(int supplies) {
		this.supplies = supplies;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public int getUserToiletId() {
		return userToiletId;
	}

	public void setUserToiletId(int userToiletId) {
		this.userToiletId = userToiletId;
	}

	public int getToiletId() {
		return toiletId;
	}

	public void setToiletId(int toiletId) {
		this.toiletId = toiletId;
	}
}