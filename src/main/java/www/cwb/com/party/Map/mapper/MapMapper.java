package www.cwb.com.party.Map.mapper;


import java.util.List;

import www.cwb.com.party.Map.vo.MapVO;
import www.cwb.com.party.Map.vo.ScaleVO;


public interface MapMapper {

	public List<MapVO> getAllMaps();
	public int insertMap(MapVO map);
	public List<MapVO> getMarkers(ScaleVO scaleVO);
}
