package teamD.module.mvc.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import teamD.module.mvc.dao.ProductDaoInter;
import teamD.module.mvc.dto.ProductVO;
import teamD.module.mvc.dto.SCategoryVO;

@RestController
public class PrRestController {
	@Autowired
	private ProductDaoInter dao;
	
	@GetMapping(value = "/sclist", produces = "application/json; charset=utf-8")
	public List<SCategoryVO> scList (int lcnum){	
		List<SCategoryVO> list;
			list = dao.scList(lcnum);
		return list;
	}

	@GetMapping(value = "/prlist", produces = "application/json; charset=utf-8")
	public Map<String, Object> prList (int lcnum){	
		Map<String, Object> listMap = new HashMap<String, Object>();
		List<ProductVO> list;
		list = dao.SearchByCategoryList(lcnum);
		
		listMap.put("sclist", dao.scList(lcnum)); 
		listMap.put("sprlist", list);
		return listMap;
	}
	
}
