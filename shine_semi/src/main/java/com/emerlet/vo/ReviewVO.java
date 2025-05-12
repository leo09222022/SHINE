package com.emerlet.vo;

import java.util.Date;

public class ReviewVO {
	private int reviewId;
	private int cleanliness;
	private int safety;
	private Date createdAt;
	private int userToiletId;
	private int toiletId;
	public ReviewVO(int reviewId, int cleanliness, int safety, Date createdAt, int userToiletId, int toiletId) {
		super();
		this.reviewId = reviewId;
		this.cleanliness = cleanliness;
		this.safety = safety;
		this.createdAt = createdAt;
		this.userToiletId = userToiletId;
		this.toiletId = toiletId;
	}
	public ReviewVO() {
		super();
		// TODO Auto-generated constructor stub
	}
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
