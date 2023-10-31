package teamD.module.mvc.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import teamD.module.mvc.dao.ProductDaoInter;
import teamD.module.mvc.dto.SCategoryVO;

@RestController
public class PrRestController {
	@Autowired
	private ProductDaoInter dao;
	
	@GetMapping(value = "/sclist", produces = "application/json; charset=utf-8")
	public List<SCategoryVO> scList (int lcnum){		
		List<SCategoryVO> list = dao.scList(lcnum);
		return list;
	}
	
	
}
