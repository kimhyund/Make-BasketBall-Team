package www.cwb.com.party.Board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.cwb.com.framework.PageDTO;
import www.cwb.com.framework.Pair;
import www.cwb.com.party.Board.mapper.BoardMapper;
import www.cwb.com.party.Board.mapper.ReplyMapper;
import www.cwb.com.party.Board.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	public int getTotalCount(int bno) {
		return replyMapper.getTotalCount(bno);
	}
	
	@Override
	public Pair<Integer, List<ReplyVO>> getPagingReplyofBoard(PageDTO cri, int bno) {
		Pair<Integer, List<ReplyVO>> ret = new Pair<>();
		ret.setFirst(replyMapper.getTotalCount(bno));
		ret.setSecond(replyMapper.getPagingReplyofBoard(cri, bno));
		return ret;
	}
	@Override
	public ReplyVO getSingleReply(int rno) {
		return replyMapper.getSingleReply(rno);
	}

	@Transactional
	public int insertReply(ReplyVO replyVO) {
		boardMapper.updateReplyCount(replyVO.getBno(), 1);
		return replyMapper.insertReply(replyVO);
	}

	@Override
	public int deleteReply(int bno, int rno) {
		boardMapper.updateReplyCount(bno, -1);
		return replyMapper.deleteReply(rno);
	}

	@Override
	public int updateReply(ReplyVO replyVO) {
		return replyMapper.updateReply(replyVO);
	}
	//게시글 삭제 시 동일 트랜젝션으로 함께 모든 부속 댓글 삭제하기
	public int deleteReplyOfBoard(int bno) {
			return replyMapper.deleteReplyOfBoard(bno);
		}
	
}
