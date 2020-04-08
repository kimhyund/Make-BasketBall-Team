package www.cwb.com.party.Member.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.cwb.com.framework.util.SecurityUtil;
import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Member.service.MemberService;
import www.cwb.com.party.Member.vo.MemberVO;
import www.cwb.com.security.domain.CustomUser;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private MemberService memberService;
	//@Autowired
	private PasswordEncoder passwordEncoder; 

	@GetMapping(value="checkUserId")
	@ResponseBody
	public ResponseEntity<Boolean> checkUserId(String id) {
		MemberVO member;
		Boolean ret = false;
		
		member = memberService.getMember(id);
		if (member != null) 	ret = true;
		return new ResponseEntity<Boolean>(ret, HttpStatus.OK);
	}
 
	@GetMapping(value="checkPassword")
	@ResponseBody
	public ResponseEntity<Boolean> checkPassword(String id, String password) {
		MemberVO member;
		Boolean ret = false;
		
		member = memberService.getMember(id);
		if (member != null) {
			if (passwordEncoder.matches(password, member.getPassword())) 	ret = true;	
		}
		return new ResponseEntity<Boolean>(ret, HttpStatus.OK);
	}
	
	//@GetMapping("/register")
	public String createPost() {
		return "log/register";
	}

	@GetMapping("/user")
	public String profileMNG(Model model) {
		CustomUser currentMember = SecurityUtil.getCurrentMember();
		String uid = currentMember.getMember().getId();
		String unickname = currentMember.getMember().getNickName();
		String uemail = currentMember.getMember().getEmail();
		float uheight = currentMember.getMember().getHeight();
		String ugender = currentMember.getMember().getGender();
		String uaddress = currentMember.getMember().getAddress();
		String uposition = currentMember.getMember().getPosition();
		List<ChatVO> team_lists = memberService.getTeam(uid);
		List<MemberVO> request_lists = memberService.getRequest(uid);
		model.addAttribute("teamLists", team_lists);
		model.addAttribute("userId", uid);
		model.addAttribute("userNickName", unickname);
		model.addAttribute("userEmail", uemail);
		model.addAttribute("userHeight", uheight);
		model.addAttribute("userGender", ugender);
		model.addAttribute("userAddress", uaddress);
		model.addAttribute("userPosition", uposition);
		return "log/user";
	}
	
	//@GetMapping("/signoff")
	public String signOff() {
		return "log/signoff";
	}
	
	@GetMapping("/profile")
	public String createProfile(Model model) {
		CustomUser currentMember = SecurityUtil.getCurrentMember();
		model.addAttribute("member", currentMember.getMember());
		return "log/profile";
	}
	
	@GetMapping("/modify")
	public String modifyMember(Model model) {
		CustomUser currentMember = SecurityUtil.getCurrentMember();
		model.addAttribute("member", currentMember.getMember());
		return "log/modify";
	}
	
	@GetMapping("/party/signOutPage")
	public String createSignout() {
		return "signout";
	}
	
	
	
	@PostMapping("/insert.do")
	public String insertMember(MemberVO memberVO, RedirectAttributes rttr) {
		memberVO.setPassword(passwordEncoder.encode(memberVO.getPassword()));
		memberService.insertMember(memberVO);
		rttr.addFlashAttribute("result", memberVO.getId());
		return "redirect:/customLogin";
	}

	@PostMapping("/update.do")
	public String updateMember(MemberVO memberVO, RedirectAttributes rttr) {
		CustomUser currentMember = SecurityUtil.getCurrentMember();
		memberVO.setId(currentMember.getUsername());
		memberService.updateMember(memberVO);
		rttr.addFlashAttribute("result", "수정 처리완료");
		return "redirect:/board/list";
	}

	@PostMapping("/updateProfile")
	public String updateProfile(MemberVO memberVO, RedirectAttributes rttr) {
		CustomUser currentMember = SecurityUtil.getCurrentMember();
		memberVO.setId(currentMember.getUsername());
		memberService.updateProfile(memberVO);
		rttr.addFlashAttribute("result", "수정 처리완료");
		return "redirect:/board/list";
	}
	
	@PostMapping("/deleteMember")
	public String deleteMember(MemberVO memberVO, RedirectAttributes rttr) {
		CustomUser currentMember = SecurityUtil.getCurrentMember();
		memberVO.setId(currentMember.getUsername());
		memberService.deleteMember(memberVO);
		rttr.addFlashAttribute("result", "탈퇴 처리완료");
		return "redirect:/customLogin";
	}
	
	@GetMapping("/rqApproved/{user_id}/{team_id}")
	public ResponseEntity<String> deleteRequest(@PathVariable("user_id") String user_id,
			@PathVariable("team_id") String team_id) {
		int cnt = memberService.rqApproved(user_id, team_id);
		return cnt >= 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping("/rqRejected/{user_id}/{team_id}")
	public ResponseEntity<String> rejectRequest(@PathVariable("user_id") String user_id,
			@PathVariable("team_id") String team_id) {
		int cnt = memberService.rqRejected(user_id, team_id);
		return cnt == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="getRequest/{id}")
	public ResponseEntity<List> getPagingReplyofBoard(@PathVariable("id") String id){
		List<MemberVO> requests = memberService.getRequest(id);
		List kkk = new ArrayList();
		for (MemberVO request : requests) {
			Map<String, String> qqq = new HashMap<String, String>();
			String rid = request.getId();
			String position = request.getPosition();
			qqq.put("rid", rid);
			qqq.put("position", position);
			List<ChatVO> rTeams = request.getTeamLists();
			for (ChatVO rTeam : rTeams) {
				String rTid = rTeam.getTeam_id();
				qqq.put("rTid", rTid);
			}
			
			kkk.add(qqq);
		}
		return new ResponseEntity<List> (kkk, HttpStatus.OK);
	}

}
