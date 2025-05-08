package com.emerlet.vo;

import java.util.Date;

public class ToiletVO {
    private double lat;
    private double lng;
    private String name;
    private String addressRoad;
    private String addressLot;
    private int maleToilet;
    private int maleUrinal;
    private int maleDisabledToilet;
    private int maleDisabledUrinal;
    private int maleChildToilet;
    private int maleChildUrinal;
    private int femaleToilet;
    private int femaleDisabledToilet;
    private int femaleChildToilet;
    private String phoneNumber;
    private String openTimeDetail;
    private int hasEmergencyBell;
    private String emergencyBellLocation;
    private int hasCctv;
    private int hasDiaperTable;
    private String diaperTableLocation;
    private Date dataReferenceDate;

    public ToiletVO() {}

    public double getLat() { return lat; }
    public void setLat(double lat) { this.lat = lat; }

    public double getLng() { return lng; }
    public void setLng(double lng) { this.lng = lng; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddressRoad() { return addressRoad; }
    public void setAddressRoad(String addressRoad) { this.addressRoad = addressRoad; }

    public String getAddressLot() { return addressLot; }
    public void setAddressLot(String addressLot) { this.addressLot = addressLot; }

    public int getMaleToilet() { return maleToilet; }
    public void setMaleToilet(int maleToilet) { this.maleToilet = maleToilet; }

    public int getMaleUrinal() { return maleUrinal; }
    public void setMaleUrinal(int maleUrinal) { this.maleUrinal = maleUrinal; }

    public int getMaleDisabledToilet() { return maleDisabledToilet; }
    public void setMaleDisabledToilet(int maleDisabledToilet) { this.maleDisabledToilet = maleDisabledToilet; }

    public int getMaleDisabledUrinal() { return maleDisabledUrinal; }
    public void setMaleDisabledUrinal(int maleDisabledUrinal) { this.maleDisabledUrinal = maleDisabledUrinal; }

    public int getMaleChildToilet() { return maleChildToilet; }
    public void setMaleChildToilet(int maleChildToilet) { this.maleChildToilet = maleChildToilet; }

    public int getMaleChildUrinal() { return maleChildUrinal; }
    public void setMaleChildUrinal(int maleChildUrinal) { this.maleChildUrinal = maleChildUrinal; }

    public int getFemaleToilet() { return femaleToilet; }
    public void setFemaleToilet(int femaleToilet) { this.femaleToilet = femaleToilet; }

    public int getFemaleDisabledToilet() { return femaleDisabledToilet; }
    public void setFemaleDisabledToilet(int femaleDisabledToilet) { this.femaleDisabledToilet = femaleDisabledToilet; }

    public int getFemaleChildToilet() { return femaleChildToilet; }
    public void setFemaleChildToilet(int femaleChildToilet) { this.femaleChildToilet = femaleChildToilet; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getOpenTimeDetail() { return openTimeDetail; }
    public void setOpenTimeDetail(String openTimeDetail) { this.openTimeDetail = openTimeDetail; }

    public int getHasEmergencyBell() { return hasEmergencyBell; }
    public void setHasEmergencyBell(int hasEmergencyBell) { this.hasEmergencyBell = hasEmergencyBell; }

    public String getEmergencyBellLocation() { return emergencyBellLocation; }
    public void setEmergencyBellLocation(String emergencyBellLocation) { this.emergencyBellLocation = emergencyBellLocation; }

    public int getHasCctv() { return hasCctv; }
    public void setHasCctv(int hasCctv) { this.hasCctv = hasCctv; }

    public int getHasDiaperTable() { return hasDiaperTable; }
    public void setHasDiaperTable(int hasDiaperTable) { this.hasDiaperTable = hasDiaperTable; }

    public String getDiaperTableLocation() { return diaperTableLocation; }
    public void setDiaperTableLocation(String diaperTableLocation) { this.diaperTableLocation = diaperTableLocation; }

    public Date getDataReferenceDate() { return dataReferenceDate; }
    public void setDataReferenceDate(Date dataReferenceDate) { this.dataReferenceDate = dataReferenceDate; }
}
