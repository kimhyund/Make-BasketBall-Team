package www.cwb.com.party.Member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.cwb.com.party.Chat.mapper.ChatMapper;
import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Member.mapper.MemberMapper;
import www.cwb.com.party.Member.vo.MemberVO;
import www.cwb.com.party.Team.mapper.TeamMapper;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private TeamMapper teamMapper;
	@Autowired
	private ChatMapper chatMapper;

	public List<MemberVO> getAllMember() {
		List<MemberVO> listAllMember = memberMapper.getAllMember();
		return listAllMember;
	}

	public MemberVO getMember(String uid) {
		return memberMapper.getMember(uid);
	}
	
	public List<ChatVO> getTeam(String uid) {
		List<ChatVO> listTeam = memberMapper.getTeam(uid);
		return listTeam;
	}
	
	public int insertMember(MemberVO memberVO) {
		return memberMapper.insertMember(memberVO);
	}
	
	public int updateMember(MemberVO memberVO) {
		return memberMapper.updateMember(memberVO);
	}
	public int updateProfile(MemberVO memberVO) {
		return memberMapper.updateProfile(memberVO);
	}
	public int deleteMember(MemberVO memberVO) {
		return memberMapper.deleteMember(memberVO);
	}
	
	public int deleteMemberByColl(List<String> listId) {
		return memberMapper.deleteMemberByColl(listId);
	}
	public List<MemberVO> getRequest(String uid){
		List<MemberVO> request = memberMapper.getRequest(uid);
		return request;
	}
	
	@Transactional
	public int rqApproved(String user_id, String team_id ) {
		teamMapper.updateMemberCount(team_id, 1);
		return chatMapper.rqApproved(user_id, team_id);
	}
	public int rqRejected(String user_id, String team_id) {
		return chatMapper.rqRejected(user_id, team_id);
	}
}
