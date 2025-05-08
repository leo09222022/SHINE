package com.emerlet.vo;

import java.util.Date;

public class ToiletVO {
    private double lat;
    private double lng;
    private String name;
    private String address_road;
    private String address_lot;
    private int male_toilet;
    private int male_urinal;
    private int male_disabled_toilet;
    private int male_disabled_urinal;
    private int male_child_toilet;
    private int male_child_urinal;
    private int female_toilet;
    private int female_disabled_toilet;
    private int female_child_toilet;
    private String phone_number;
    private String open_time_detail;
    private int has_emergency_bell;
    private String emergency_bell_location;
    private int has_cctv;
    private int has_diaper_table;
    private String diaper_table_location;
    private Date data_reference_date;

    // 기본 생성자
    public ToiletVO() {
        super();
    }

    // getter & setter

    public double getLat() { return lat; }
    public void setLat(double lat) { this.lat = lat; }

    public double getLng() { return lng; }
    public void setLng(double lng) { this.lng = lng; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress_road() { return address_road; }
    public void setAddress_road(String address_road) { this.address_road = address_road; }

    public String getAddress_lot() { return address_lot; }
    public void setAddress_lot(String address_lot) { this.address_lot = address_lot; }

    public int getMale_toilet() { return male_toilet; }
    public void setMale_toilet(int male_toilet) { this.male_toilet = male_toilet; }

    public int getMale_urinal() { return male_urinal; }
    public void setMale_urinal(int male_urinal) { this.male_urinal = male_urinal; }

    public int getMale_disabled_toilet() { return male_disabled_toilet; }
    public void setMale_disabled_toilet(int male_disabled_toilet) { this.male_disabled_toilet = male_disabled_toilet; }

    public int getMale_disabled_urinal() { return male_disabled_urinal; }
    public void setMale_disabled_urinal(int male_disabled_urinal) { this.male_disabled_urinal = male_disabled_urinal; }

    public int getMale_child_toilet() { return male_child_toilet; }
    public void setMale_child_toilet(int male_child_toilet) { this.male_child_toilet = male_child_toilet; }

    public int getMale_child_urinal() { return male_child_urinal; }
    public void setMale_child_urinal(int male_child_urinal) { this.male_child_urinal = male_child_urinal; }

    public int getFemale_toilet() { return female_toilet; }
    public void setFemale_toilet(int female_toilet) { this.female_toilet = female_toilet; }

    public int getFemale_disabled_toilet() { return female_disabled_toilet; }
    public void setFemale_disabled_toilet(int female_disabled_toilet) { this.female_disabled_toilet = female_disabled_toilet; }

    public int getFemale_child_toilet() { return female_child_toilet; }
    public void setFemale_child_toilet(int female_child_toilet) { this.female_child_toilet = female_child_toilet; }

    public String getPhone_number() { return phone_number; }
    public void setPhone_number(String phone_number) { this.phone_number = phone_number; }

    public String getOpen_time_detail() { return open_time_detail; }
    public void setOpen_time_detail(String open_time_detail) { this.open_time_detail = open_time_detail; }

    public int getHas_emergency_bell() { return has_emergency_bell; }
    public void setHas_emergency_bell(int has_emergency_bell) { this.has_emergency_bell = has_emergency_bell; }

    public String getEmergency_bell_location() { return emergency_bell_location; }
    public void setEmergency_bell_location(String emergency_bell_location) { this.emergency_bell_location = emergency_bell_location; }

    public int getHas_cctv() { return has_cctv; }
    public void setHas_cctv(int has_cctv) { this.has_cctv = has_cctv; }

    public int getHas_diaper_table() { return has_diaper_table; }
    public void setHas_diaper_table(int has_diaper_table) { this.has_diaper_table = has_diaper_table; }

    public String getDiaper_table_location() { return diaper_table_location; }
    public void setDiaper_table_location(String diaper_table_location) { this.diaper_table_location = diaper_table_location; }

    public Date getData_reference_date() { return data_reference_date; }
    public void setData_reference_date(Date data_reference_date) { this.data_reference_date = data_reference_date; }
}
