package www.cwb.com.controllers;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommonController {
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		System.out.println(auth);
		model.addAttribute("msg", "access Denied");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {
		
		System.out.println("error: " + error);
		System.out.println("logout: " + logout);
		
		if (error != null) {
			model.addAttribute("error", "아이디와 비밀번호를 다시 확인해주세요");
		}
		if (logout != null) {
			model.addAttribute("logout", "logged out");
		}
	}
	@GetMapping("/customLogout")
	public void logoutGET() {
		
		System.out.println("Log out");
	}
	
}
