package www.cwb.com.party.Chat.mapper;

import org.apache.ibatis.annotations.Param;

import www.cwb.com.party.Chat.vo.ChatVO;

public interface ChatMapper {
	public int joinRequest(ChatVO chatVO);
	public int rqApproved(@Param(value = "user_id") String user_id,
			@Param(value = "team_id") String team_id);
	public int rqRejected(@Param(value = "user_id") String user_id,
			@Param(value = "team_id") String team_id);
	public ChatVO requestCheck(ChatVO chatVO);
	public int deleteTeam(String team_id);
}
