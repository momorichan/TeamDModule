package teamD.module.mvc.controller.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import teamD.module.mvc.dao.ProductDaoInter;
import teamD.module.mvc.dto.PageVO;
import teamD.module.mvc.dto.ProductVO;

@Controller
public class ProductController {
	@Autowired
	private ProductDaoInter productDaoInter;
	@Autowired
	private PageVO pageVO;
	
	@GetMapping("/prInsert")
	public String prInsertForm(Model model) {
		model.addAttribute("lclist", productDaoInter.lcList());
		return "product/prInsertForm";
	}
	
	@RequestMapping("/prList")
	   public String prListForm(Model model, @RequestParam Map<String, String> paramMap) {
	         String cPage = paramMap.get("cPage");
	         pageVO.setTotalRecord(productDaoInter.getTotal(paramMap));
	         int totalRecord = pageVO.getTotalRecord();
	         pageVO.setTotalPage((int)Math.ceil(totalRecord/(double)pageVO.getNumPerPage()));
	         pageVO.setTotalBlock((int) Math.ceil((double) pageVO.getTotalPage()/ pageVO.getPagePerBlock()));

	         if(cPage != null) {
	            pageVO.setNowPage(Integer.parseInt(cPage));
	         }else {
	            pageVO.setNowPage(1);
	         }
	         pageVO.setBeginPerPage((pageVO.getNowPage() - 1) * pageVO.getNumPerPage() + 1);
	         pageVO.setEndPerPage((pageVO.getBeginPerPage()-1) + pageVO.getNumPerPage());
	         Map<String, String> map = new HashMap<String,String>();
	         map.put("begin",String.valueOf(pageVO.getBeginPerPage()));
	         map.put("end",String.valueOf(pageVO.getEndPerPage()));
	         map.putAll(paramMap);
	         for(Map.Entry<String , String> e : map.entrySet()) {
	            System.out.println(e.getKey()+","+e.getValue());
	         }
	         List<ProductVO> list = productDaoInter.productList(map);
	         System.out.println("Size : " + list.size());
	         int StartPage = (int)((pageVO.getNowPage() - 1) / pageVO.getPagePerBlock()) * pageVO.getPagePerBlock() +1;
	         int endpage = StartPage + pageVO.getPagePerBlock() - 1 ;
	         if(endpage > pageVO.getTotalPage()) {
	            endpage = pageVO.getTotalPage();
	         }
	         model.addAttribute("startPage",StartPage);
	         model.addAttribute("endPage",endpage);
	         model.addAttribute("page",pageVO);
	         model.addAttribute("list",list);
	         model.addAttribute("searchType",map.get("searchType"));
	         model.addAttribute("searchValue",map.get("searchValue"));
	         
	      return "product/prList";
	   }
	

	
}
