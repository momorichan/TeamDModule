package teamD.module.mvc.controller.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import teamD.module.mvc.dao.ProductDaoInter;
import teamD.module.mvc.dto.ProductVO;

@Controller
public class ProductController {
	@Autowired
	private ProductDaoInter productDaoInter;
	
	
	@GetMapping("/prInsert")
	public String prInsertForm(Model model) {
		model.addAttribute("lclist", productDaoInter.lcList());
		return "product/prInsertForm";
	}
	
	@GetMapping("/prList")
	public String prList(Model model) {
		List<ProductVO> list = productDaoInter.prList();
		System.out.println("리스트 테스트" + list);
		model.addAttribute("list",list);
		return "product/prList";
	}
	

	
}
