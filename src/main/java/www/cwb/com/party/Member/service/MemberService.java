package www.cwb.com.party.Member.service;

import java.util.List;

import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Member.vo.MemberVO;

public interface MemberService {
	public List<MemberVO> getAllMember();
	public MemberVO getMember(String id);
	public List<ChatVO> getTeam(String uid);
	public int insertMember(MemberVO memberVO);
	public int updateMember(MemberVO memberVO);
	public int updateProfile(MemberVO memberVO);
	public int deleteMember(MemberVO memberVO);
	public int deleteMemberByColl(List<String> listId);
	public List<MemberVO> getRequest(String uid);
	public int rqApproved(String user_id, String team_id);
	public int rqRejected(String user_id, String team_id);
}
