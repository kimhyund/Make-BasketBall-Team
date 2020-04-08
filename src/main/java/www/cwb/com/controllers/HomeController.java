package www.cwb.com.controllers;

import java.util.Locale;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	protected void debug(Object obj) {
		logger.debug(obj.toString());
	}
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		return "redirect:/board/list";
	}
	@RequestMapping(value = "/socket.io", method = RequestMethod.GET)
	public String createSignout1(HttpServletResponse response) {

		response.setHeader("Cache-Control", "no-cache");
		
		response.setHeader("Pragma", "no-cache");
		
		response.setDateHeader("Expires", 0);
		return "";
	}
	
	
}
