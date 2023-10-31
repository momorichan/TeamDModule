package teamD.module.mvc.controller.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import teamD.module.mvc.dao.ProductDaoInter;
import teamD.module.mvc.dto.ProductVO;

@Controller
public class ProductController {
	@Autowired
	private ProductDaoInter ProductDaoInter;
	
	
	@GetMapping("/prInsert")
	public String prInsert() {
		return "product/prInsertForm";
	}
	
	

}
