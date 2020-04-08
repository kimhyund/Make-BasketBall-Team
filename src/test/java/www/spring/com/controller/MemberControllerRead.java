package www.spring.com.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class MemberControllerRead {
	@Autowired
	private WebApplicationContext wac;
	
	//Web Browser 대행기, 즉 가짜 브라우저
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
	@Test
	public void testListBoard() throws Exception {
		MockHttpServletRequestBuilder mhsrb = MockMvcRequestBuilders.get("/member/user");
		mhsrb.param("uid", "abc1");
		ResultActions ra = mockMvc.perform(mhsrb);
		ModelMap mm = ra.andReturn().getModelAndView().getModelMap();
		System.out.println(mm);
	}

	//@Test
	public void testGetPosting() throws Exception {
		MockHttpServletRequestBuilder mhsrb = MockMvcRequestBuilders.get("/board/showDetail");
		mhsrb.param("bno", "2");
		
		ResultActions ra = mockMvc.perform(mhsrb);
		ModelMap mm = ra.andReturn().getModelAndView().getModelMap();
		System.out.println(mm);
	}
	
	//@Test
	public void testCreateBoard() throws Exception {
		MockHttpServletRequestBuilder mhsrb = MockMvcRequestBuilders.post("/member/insert.do");
		mhsrb.param("id", "admin00")
		
		.param("password", "123");
		ResultActions ra = mockMvc.perform(mhsrb);
		String vn = ra.andReturn().getModelAndView().getViewName();
		System.out.println(vn);
	}
}











