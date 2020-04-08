package www.cwb.com.party.Board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.cwb.com.framework.fileupload.controller.UploadController;
import www.cwb.com.framework.fileupload.model.AttachVO;
import www.cwb.com.party.Board.service.BoardService;
import www.cwb.com.party.Board.vo.BoardVO;
import www.cwb.com.party.model.criteria.BoardCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private UploadController uploadController;
	
	@RequestMapping("/list")
	public String listAllBoard(BoardCriteria cri, Model model) {
		List<BoardVO> listAllBoard = boardService.getListWithPagingByCondition(cri);
		model.addAttribute("listAllBoard", listAllBoard);
		int totalCnt = boardService.getTotalCount(cri);
		BoardCriteria criWithTot = new BoardCriteria(cri, totalCnt);

		model.addAttribute("pageMaker", criWithTot);
		return "board/listAllBoard";
	}
	
	//ㅏㅓㄴㅇ라ㅓㅗㅁㄴㅇ라ㅗ/showDetail?bno=2
	@GetMapping({"showDetail", "modify", "showDetail_G"})
	public void getPosting(BoardCriteria cri, int bno, Model model) {
		BoardVO board = boardService.getBoard(bno);
		model.addAttribute("board", board);
		model.addAttribute("pageMaker", cri);
	}

	@GetMapping("createPost")
	@PreAuthorize("isAuthenticated()")
	public void createPost(String type, String address, Model model) {
		model.addAttribute("masterName", BoardVO.MASTER_NAME);
		model.addAttribute("type", type);
		model.addAttribute("address", address);
	}
	
	@PostMapping("/insert.do")
	@PreAuthorize("isAuthenticated()")
	public String insertBoard(BoardVO boardVO,  RedirectAttributes rttr) {
		boardService.insertBoard(boardVO);
		System.out.println(boardVO);
		rttr.addFlashAttribute("result", boardVO.getBno());
		return "redirect:/board/list";
	}

	@PreAuthorize("principal.party.name == #boardVO.writer")
	@PostMapping("/update.do")
	public String updateBoard(@ModelAttribute("pageMaker") BoardCriteria cri, BoardVO boardVO, RedirectAttributes rttr) {
		boardService.updateBoard(boardVO);
		rttr.addFlashAttribute("result", "수정 처리 완료");

		return "redirect:/board/list" + cri.getListLink();
	}

	@PreAuthorize("principal.party.name == #writer")
	@PostMapping("deletePosting")
	public String deletePosting(@ModelAttribute("pageMaker") BoardCriteria cri, int bno, RedirectAttributes rttr) {
		List<AttachVO> listAttach = boardService.getAttachList(bno);
		
		if (boardService.deleteBoard(bno) != 0) {
			uploadController.deleteFiles(listAttach);
		}
		rttr.addFlashAttribute("result", "삭제 처리 완료");

		return "redirect:/board/list" + cri.getListLink();
	}

	@GetMapping("map")
	public void map4Location() {
		
	}

}

















