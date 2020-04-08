package www.cwb.com.party.Map.vo;

import java.util.Date;

import lombok.Data;
@Data
public class MapVO {
	private int id;
	private String name;
	private int half_court_num;
	private int full_court_num;
	private String address;
	private String user_id;
	private String content;
	private Date reg_date;
	private Date update_date;
	private float latitude;
	private float longitude;
	private int scale;

	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getHalf_court_num() {
		return half_court_num;
	}
	public void setHalf_court_num(int half_court_num) {
		this.half_court_num = half_court_num;
	}
	public int getFull_court_num() {
		return full_court_num;
	}
	public void setFull_court_num(int full_court_num) {
		this.full_court_num = full_court_num;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public float getLatitude() {
		return latitude;
	}
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	public float getLongitude() {
		return longitude;
	}
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	
	
	
	
}
