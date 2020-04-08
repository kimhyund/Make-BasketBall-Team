package www.cwb.com.party.Map.vo;

import www.cwb.com.framework.Pair;

public class LatLngInfo {
	public String name;
	public Pair<Double, Double> latlng;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Pair<Double, Double> getLatlng() {
		return latlng;
	}
	public void setLatlng(Pair<Double, Double> latlng) {
		this.latlng = latlng;
	}
	
	
	
}
