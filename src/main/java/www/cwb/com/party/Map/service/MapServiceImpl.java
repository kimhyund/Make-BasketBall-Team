package www.cwb.com.party.Map.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import www.cwb.com.party.Map.mapper.MapMapper;
import www.cwb.com.party.Map.vo.MapVO;
import www.cwb.com.party.Map.vo.ScaleVO;

@Service
public class MapServiceImpl implements MapService {
	@Autowired
	private MapMapper mapMapper;
	
	public List<MapVO> getAllMaps() {
		return mapMapper.getAllMaps();
	}
	
	public int insertMap(MapVO map) {
		return mapMapper.insertMap(map);
	}

	@Override
	public List<MapVO> getMarkers(ScaleVO scaleVO) {
		return mapMapper.getMarkers(scaleVO);
	}
}
