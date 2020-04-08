package www.cwb.com.commons.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

//@ControllerAdvice
public class CommonExectionAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonExectionAdvice.class);
	
	//@ExceptionHandler(Exception.class)
	public ModelAndView commonException(Exception e) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception", e);
		mav.setViewName("/commons/common_error");
		return mav;
	}
	
}
