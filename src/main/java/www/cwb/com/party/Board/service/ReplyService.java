package www.cwb.com.party.Board.service;

import java.util.List;

import www.cwb.com.framework.PageDTO;
import www.cwb.com.framework.Pair;
import www.cwb.com.party.Board.vo.ReplyVO;

public interface ReplyService {
	public int getTotalCount(int bno);
	public ReplyVO getSingleReply(int rno);
	public Pair<Integer, List<ReplyVO>> getPagingReplyofBoard(PageDTO cri, int bno);
	public int insertReply(ReplyVO replyVO);
	public int deleteReply(int bno, int rno);
	public int updateReply(ReplyVO replyVO);
}
