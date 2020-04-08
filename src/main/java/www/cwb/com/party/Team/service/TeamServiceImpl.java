package www.cwb.com.party.Team.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.cwb.com.party.Chat.mapper.ChatMapper;
import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Team.mapper.TeamMapper;
import www.cwb.com.party.Team.vo.TeamVO;
import www.cwb.com.party.model.criteria.BoardCriteria;

@Service
public class TeamServiceImpl implements TeamService {
	@Autowired
	private TeamMapper teamMapper;
	@Autowired
	private ChatMapper chatMapper;
	

	public TeamVO getTeam(String teamName) {
		return teamMapper.getTeam(teamName);
	}
	
	public int createTeam(TeamVO teamVO) {
		return teamMapper.createTeam(teamVO);
	}
	public List<TeamVO> getListTeam(){
		return teamMapper.getListTeam();
	}

	@Override
	public int joinRequest(ChatVO chatVO) {
		return chatMapper.joinRequest(chatVO);
	}

	@Override
	public ChatVO requestCheck(ChatVO chatVO) {
		return chatMapper.requestCheck(chatVO);
	}

	@Override
	public int getTotalCount(BoardCriteria cri) {
		return teamMapper.getTotalCount(cri);
	}

	@Override
	public List<TeamVO> getListWithPagingByCondition(BoardCriteria cri) {
		return teamMapper.getListWithPagingByCondition(cri);
	}

	@Override
	public int updateTeam(TeamVO teamVO) {
		return 	teamMapper.updateTeam(teamVO);
	}

	@Transactional
	public int deleteTeam(TeamVO teamVO) {
		chatMapper.deleteTeam(teamVO.getTeamName());
		return teamMapper.deleteTeam(teamVO);
	}
	
	
}
