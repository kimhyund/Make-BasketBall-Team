package www.cwb.com.party.Map.vo;

import lombok.Data;

@Data
public class ScaleVO {
	int scale;
	float swLat;
	float swLng;
	float neLat;
	float neLng;
	public int getScale() {
		return scale;
	}
	public void setScale(int scale) {
		this.scale = scale;
	}
	public float getSwLat() {
		return swLat;
	}
	public void setSwLat(float swLat) {
		this.swLat = swLat;
	}
	public float getSwLng() {
		return swLng;
	}
	public void setSwLng(float swLng) {
		this.swLng = swLng;
	}
	public float getNeLat() {
		return neLat;
	}
	public void setNeLat(float neLat) {
		this.neLat = neLat;
	}
	public float getNeLng() {
		return neLng;
	}
	public void setNeLng(float neLng) {
		this.neLng = neLng;
	}
	
	
	
	
}
