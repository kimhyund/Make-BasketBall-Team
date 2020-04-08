package www.cwb.com.party.Board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import www.cwb.com.framework.PageDTO;
import www.cwb.com.framework.Pair;
import www.cwb.com.party.Board.service.ReplyService;
import www.cwb.com.party.Board.vo.ReplyVO;

@Controller
@RequestMapping("/reply/*")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@GetMapping(value="getReply/{rno}")
	public ResponseEntity<ReplyVO> getReply (@PathVariable("rno") int rno,  Model model) {
		return new ResponseEntity<ReplyVO>(replyService.getSingleReply(rno), HttpStatus.OK);
	}
	
	@GetMapping(value="getPagingReply/{bno}/{pageNum}/{amount}")
	public ResponseEntity<Pair<Integer, List<ReplyVO>>> getPagingReplyofBoard(
			@PathVariable("bno") int bno,
			@PathVariable("pageNum") int pageNum,
			@PathVariable("amount") int amount){
		PageDTO cri = new PageDTO(pageNum, amount); 
		return new ResponseEntity<Pair<Integer, List<ReplyVO>>>(replyService.getPagingReplyofBoard(cri, bno), HttpStatus.OK);
	}
	
	@PostMapping("/createReply")
	public ResponseEntity<String> insertReply(@RequestBody ReplyVO replyVO){
		int cnt = replyService.insertReply(replyVO);
		return cnt == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping("/deleteReply/{bno}/{rno}")
	public ResponseEntity<String> deleteReply(@PathVariable("bno") int bno, @PathVariable("rno") int rno) {
		int cnt = replyService.deleteReply(bno, rno);
		return cnt == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping("updateReply")
	public ResponseEntity<String> updateReply(@RequestBody ReplyVO replyVO) {
		int cnt = replyService.updateReply(replyVO);
		return cnt == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("error", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
