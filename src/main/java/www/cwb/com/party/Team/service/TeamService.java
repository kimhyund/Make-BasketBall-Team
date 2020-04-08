package www.cwb.com.party.Team.service;

import java.util.List;

import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Team.vo.TeamVO;
import www.cwb.com.party.model.criteria.BoardCriteria;

public interface TeamService {
	public int getTotalCount(BoardCriteria cri);
	public List<TeamVO> getListWithPagingByCondition(BoardCriteria cri);
	public TeamVO getTeam(String teamName);
	public List<TeamVO> getListTeam();
	public int createTeam(TeamVO teamVO);
	public int joinRequest(ChatVO chatVO);
	public ChatVO requestCheck(ChatVO chatVO);
	
	public int updateTeam(TeamVO teamVO);
	public int deleteTeam(TeamVO teamVO);
}
