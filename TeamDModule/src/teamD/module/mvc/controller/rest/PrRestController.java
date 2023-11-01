package teamD.module.mvc.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

	@GetMapping(value = "/prlcList", produces = "application/json; charset=utf-8")
	public Map<String, Object> prlcList (@RequestParam Map<String, String> map){	
		Map<String, Object> listMap = new HashMap<String, Object>();
		List<ProductVO> list;
		list = dao.SearchByCategoryList(map);
		listMap.put("sclist", dao.scList(Integer.parseInt(map.get("lcnum")))); 
		listMap.put("sprlist", list);
		return listMap;
	}
	
	
	@GetMapping(value = "/prscList", produces = "application/json; charset=utf-8")
	public List<ProductVO> prscList (@RequestParam Map<String, String> map){	
		List<ProductVO> list;
		list = dao.SearchByCategoryList(map);
		return list;
	}
	
}
