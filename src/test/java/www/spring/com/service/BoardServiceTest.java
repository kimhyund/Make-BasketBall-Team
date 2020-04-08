package www.spring.com.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import www.cwb.com.party.Chat.vo.ChatVO;
import www.cwb.com.party.Member.service.MemberService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {
	@Autowired
	private MemberService memberService;
	
	/*@Test
	public void testCreateBoard() {
		MemberVO boardVO = new MemberVO();
		MemberVO
		MemberVO.
		MemberVO.
		
		memberService.insertBoard(boardVO);
		System.out.println(boardVO);
	}*/

	@Test
	public void testListAllBoard() {
		
		String uid = "abc1";
		List<ChatVO> list = memberService.getTeam(uid);
		for (ChatVO board : list) {
			System.out.println(board);
			log.info(board);
		}
	}

}











