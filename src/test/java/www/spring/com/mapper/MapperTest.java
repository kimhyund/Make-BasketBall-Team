package www.spring.com.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import www.cwb.com.party.Team.mapper.TeamMapper;
import www.cwb.com.party.Team.vo.TeamVO;
import www.cwb.com.party.model.criteria.BoardCriteria;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MapperTest {


	
	@Autowired
	private TeamMapper teamMapper;
	
	
	@Test
	public void testRead() {
		 BoardCriteria cri = new BoardCriteria(); 
		 cri.setPageNum(1);
		List<TeamVO> vo = teamMapper.getListWithPagingByCondition(cri);
		
		System.out.println(vo);
		
		//System.out.println(board);
		//log.info(board);
	}
}











