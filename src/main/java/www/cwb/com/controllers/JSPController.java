package www.cwb.com.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.cwb.com.framework.BaseController;

@Controller
public class JSPController extends BaseController{

	private final static String CALL_PATH_PREFIX = "/call";
	
	@RequestMapping(CALL_PATH_PREFIX + "/**")
	public String CallPage(HttpServletRequest request, RedirectAttributes reAttr) {
		String path = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);

		path = path.replace(CALL_PATH_PREFIX + "/", "");
		
		if(path.indexOf(".") > -1) {
			path = path.substring(0, path.lastIndexOf("."));
		}
		
		return "" + path;
	}
}

