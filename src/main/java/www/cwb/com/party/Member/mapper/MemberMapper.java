package www.cwb.com.party.Member.mapper;

import java.util.List;

import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Member.vo.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userId);
	public MemberVO getMember(String id);
	public List<MemberVO> getAllMember();
	public List<MemberVO> getMemberTwoLatest();
	public List<ChatVO> getTeam(String uid);
	public List<MemberVO> getRequest(String uid);
	
	public int insertMember(MemberVO memberVO);
	public int updateMember(MemberVO member);
	public int updateProfile(MemberVO member);
	public int deleteMember(MemberVO memberVO);
	public int deleteMemberByColl(List<String> listId);
}
