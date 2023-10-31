package teamD.module.mvc.controller.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import teamD.module.mvc.dao.ProductDaoInter;

@RestController
public class PrRestController {
	
	@Autowired
	private ProductDaoInter productDaoInter;
	
	@GetMapping("/scSelectList")
	public String scSelectList(int lcnum) {
		model.addAttribute("lclist", productDaoInter.lcList());
		return "product/prInsertForm";
	}	
}
