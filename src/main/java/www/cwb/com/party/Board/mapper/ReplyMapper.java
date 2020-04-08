package www.cwb.com.party.Board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import www.cwb.com.framework.PageDTO;
import www.cwb.com.party.Board.vo.ReplyVO;

public interface ReplyMapper {
	public ReplyVO getSingleReply(int rno);
	public ReplyVO getReply(int rno);
	public int getTotalCount (int bno);
	public List<ReplyVO> getPagingReplyofBoard(
			@Param("cri") PageDTO cri,
			@Param("bno") int bno);
	
	public Integer getOldestReply();
	public Integer getOldestBoardIdHavingReply();
	
	
	public int insertReply(ReplyVO replyVO);
	public int deleteReply(int rno);
	public int updateReply(ReplyVO replyVO);
	public int deleteReplyOfBoard(int bno);
}
