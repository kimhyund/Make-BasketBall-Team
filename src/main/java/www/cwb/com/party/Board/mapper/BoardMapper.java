package www.cwb.com.party.Board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import www.cwb.com.framework.PageDTO;
import www.cwb.com.party.Board.vo.BoardVO;
import www.cwb.com.party.model.criteria.BoardCriteria;

public interface BoardMapper {
	public int getTotalCount(@Param("cri") BoardCriteria cri);
	public List<BoardVO> getAllBoard();
	public List<BoardVO> getListWithPagingByCondition(@Param("cri") BoardCriteria cri);
	public BoardVO getBoard(@Param("bno") int bno, @Param("masterName") String masterName);
	public BoardVO getBoardLatest();
	public List<BoardVO> getBoardTwoLatest();
	public int insertBoard(BoardVO boardVO);
	public int updateBoard(BoardVO boardVO);
	public void updateReplyCount(@Param("bno") int bno, @Param("amount") int amount);
	public int deleteBoard(int bno);
	public int deleteBoardByColl(List<Integer> listBno);


	public List<BoardVO> getListWithPaging(PageDTO cri);
}
