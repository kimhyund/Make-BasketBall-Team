package www.cwb.com.party.Team.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import www.cwb.com.party.Board.vo.BoardVO;
import www.cwb.com.party.Team.vo.TeamVO;
import www.cwb.com.party.model.criteria.BoardCriteria;

public interface TeamMapper {
	
	public TeamVO getTeam(String teamName);
	public int createTeam(TeamVO teamVO);
	public List<TeamVO> getListTeam();
	public int updateTeam(TeamVO teamVO);
	public int deleteTeam(TeamVO teamVO);
	
	public int updateMemberCount(@Param("pid") String pid, @Param("amount") int amount);
	public int getTotalCount(@Param("cri") BoardCriteria cri);
	public List<TeamVO> getListWithPagingByCondition(@Param("cri") BoardCriteria cri);
}
