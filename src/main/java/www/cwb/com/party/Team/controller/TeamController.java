package www.cwb.com.party.Team.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.cwb.com.framework.util.SecurityUtil;
import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Team.service.TeamService;
import www.cwb.com.party.Team.vo.TeamVO;
import www.cwb.com.party.model.criteria.BoardCriteria;
import www.cwb.com.security.domain.CustomUser;

@Controller
@RequestMapping("/team/*")
public class TeamController {
	@Autowired
	private TeamService teamService;
	

	@RequestMapping("/list")
	public String listAllMember(BoardCriteria cri, Model model) {
		System.out.println("1" + cri.getPageNum());
		System.out.println("2"+ cri.getAmount());
		List<TeamVO> ListTeam = teamService.getListWithPagingByCondition(cri);
		model.addAttribute("listAllTeams", ListTeam);
		int totalCnt = teamService.getTotalCount(cri);
		BoardCriteria criWithTot = new BoardCriteria(cri, totalCnt);
		model.addAttribute("pageMaker", criWithTot);
		return "team/TeamList";
	}
 

	@PostMapping("/insert.do")
	public String insertBoard(TeamVO teamVO, RedirectAttributes rttr) {
		//팀생성시 leader값을 현재 로그인 한 유저이름으로 설정
		CustomUser currenUser = SecurityUtil.getCurrentMember();
		teamVO.setLeader(currenUser.getUsername());
		teamService.createTeam(teamVO);
		rttr.addFlashAttribute("result", teamVO.getCid());
		return "redirect:./list";
	}
	
	@GetMapping({"/teamManage","/modify"})
	public void teamDetail(String teamName, Model model) {
		TeamVO team = teamService.getTeam(teamName);
		List<String> mList = new ArrayList<String>();
		for(ChatVO member : team.getMemberList()) {
			String uid = member.getUser_id();
			mList.add(uid);
		}
		System.out.println(team);
		System.out.println(mList);
		model.addAttribute("team", team);
		model.addAttribute("memberList", mList);
	}
	
	@PostMapping("/join.do")
	public String joinRequest(ChatVO chatVO, RedirectAttributes rttr) {
		System.out.println(chatVO);
		teamService.joinRequest(chatVO);
		return "redirect:./list";
	}
	
	@PostMapping("/requestCheck")
	public ResponseEntity<String> requestCheck(@RequestBody ChatVO chatVO) {
		ChatVO rCheck = teamService.requestCheck(chatVO);
		System.out.println("11" + rCheck);
		int result = 1;
		if (StringUtils.isEmpty(rCheck)) {
			result = 0;
		} 
		System.out.println(result);
		return new ResponseEntity<String> (Integer.toString(result), HttpStatus.OK);
	}
	@PostMapping("/update.do")
	public String updateTeam(TeamVO teamVO, RedirectAttributes rttr) {
		teamService.updateTeam(teamVO);
		rttr.addFlashAttribute("result", "수정 처리 완료");
		return "redirect:/team/list";
	}
	@PostMapping("/deleteTeam")
	public String deleteTeam(TeamVO teamVO, RedirectAttributes rttr) {
		teamService.deleteTeam(teamVO);
		rttr.addFlashAttribute("result", "삭제 처리 완료");
		return "redirect:/team/list";
	}
	
	



}
