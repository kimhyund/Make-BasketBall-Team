package www.cwb.com.party.Board.service;

import java.util.List;

import www.cwb.com.framework.PageDTO;
import www.cwb.com.framework.fileupload.model.AttachVO;
import www.cwb.com.party.Board.vo.BoardVO;
import www.cwb.com.party.model.criteria.BoardCriteria;

public interface BoardService {
	public int getTotalCount(BoardCriteria cri);
	public List<BoardVO> getAllBoard();
	public List<BoardVO> getListWithPagingByCondition(BoardCriteria cri);
	public List<AttachVO> getAttachList(int bno);
	public BoardVO getBoard(int bno);
	public int insertBoard(BoardVO boardVO);
	public int updateBoard(BoardVO board);
	public int deleteBoard(int bno);

	public List<BoardVO> getListWithPaging(PageDTO cri);

}
