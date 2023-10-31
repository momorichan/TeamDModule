package teamD.module.mvc.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DefaultController {
	@GetMapping(value = {"/main",""})
	public String main(HttpSession session) {
		session.setAttribute("admin", "admin");
		return "temp/main";
	}
}
