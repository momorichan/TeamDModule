package teamD.module.mvc.controller.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import teamD.module.mvc.dao.ProductDaoInter;

@Controller
public class ProductController {
	@Autowired
	private ProductDaoInter productDaoInter;
	
	
	@GetMapping("/prInsert")
	public String prInsertForm(Model model) {
		model.addAttribute("lclist", productDaoInter.lcList());
		return "product/prInsertForm";
		
	}
}
