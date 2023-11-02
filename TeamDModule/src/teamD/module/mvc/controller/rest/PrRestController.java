package teamD.module.mvc.controller.rest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import teamD.module.mvc.dao.ProductDaoInter;
import teamD.module.mvc.dto.PageVO;
import teamD.module.mvc.dto.ProductVO;
import teamD.module.mvc.dto.SCategoryVO;

@RestController
public class PrRestController {
	@Autowired
	private ProductDaoInter dao;
	@Autowired
	private PageVO pageVO;

	
	//insert에 사용되는 메소드
	@GetMapping(value = "/sclist", produces = "application/json; charset=utf-8")
	public List<SCategoryVO> scList(int lcnum) {
		List<SCategoryVO> list;
		list = dao.scList(lcnum);
		return list;
	}

	//list에 사용되는 메소드
	@GetMapping(value = "/prCaList", produces = "application/json; charset=utf-8")
	public Map<String, Object> prCalist(@RequestParam Map<String, String> map) {
		Map<String, Object> listMap = new HashMap<String, Object>();

		if("lcnum".equals(map.get("key"))) {
			//key값이 lcnum일 때 sclist를 만든다.
			listMap.put("sclist", dao.scList(Integer.parseInt(map.get("lcnum"))));
		}
		
		List<ProductVO> list;
		list = dao.SearchByCategoryList(map);
		listMap.put("sprlist", list);
		
		return listMap;
	}	

	
	@GetMapping("/pagination")
	public Map<String, Object> getPaginationData(@RequestParam Map<String, String> paramMap) {
		// paramMap에 들어간 데이터 :
		for (Map.Entry<String, String> entry : paramMap.entrySet()) {
			String mykey = entry.getKey();
			String myvalue = entry.getValue();
			System.out.println("paramMap의 값             Key: " + mykey + ", Value: " + myvalue);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();

		String cPage = paramMap.get("cPage");

		System.out.println("cPage : " + cPage);
		System.out.println("NowBlock : " + pageVO.getNowBlock());
		
		pageVO.setTotalRecord(dao.getTotal(paramMap));
		int totalRecord = pageVO.getTotalRecord();

		System.out.println("totalRecord : " + totalRecord);

		pageVO.setTotalPage((int) Math.ceil(totalRecord / (double) pageVO.getNumPerPage()));
		pageVO.setTotalBlock((int) Math.ceil((double) pageVO.getTotalPage() / pageVO.getPagePerBlock()));

		if("Next".equals(cPage)) {
			int nowPage = Integer.parseInt(paramMap.get("currPage"));
			int currPage = (int)(Math.ceil((nowPage/(double)pageVO.getPagePerBlock()))) * pageVO.getPagePerBlock() + 1;
			pageVO.setNowPage(currPage);
		}else if ("Previous".equals(cPage)) {
			int nowPage = Integer.parseInt(paramMap.get("currPage"));
			int currPage = (int)(Math.ceil((nowPage/(double)pageVO.getPagePerBlock())) -1 ) * pageVO.getPagePerBlock();
			pageVO.setNowPage(currPage);
		}else if(cPage != null){
			pageVO.setNowPage(Integer.parseInt(cPage));
		} else {
			pageVO.setNowPage(1);
		}
		
		pageVO.setBeginPerPage((pageVO.getNowPage() - 1) * pageVO.getNumPerPage() + 1);
		pageVO.setEndPerPage((pageVO.getBeginPerPage() - 1) + pageVO.getNumPerPage());
		Map<String, String> map = new HashMap<String, String>();
		map.put("begin", String.valueOf(pageVO.getBeginPerPage()));
		map.put("end", String.valueOf(pageVO.getEndPerPage()));
		map.putAll(paramMap);
		int StartPage = (int) ((pageVO.getNowPage() - 1) / pageVO.getPagePerBlock()) * pageVO.getPagePerBlock() + 1;
		int endpage = StartPage + pageVO.getPagePerBlock() - 1;
		if (endpage > pageVO.getTotalPage()) {
			endpage = pageVO.getTotalPage();
		}
		System.out.println("startPage : " + StartPage);
		System.out.println("endPage : " + endpage);
		System.out.println("page : " + pageVO);
		System.out.println("searchType : " + map.get("searchType"));
		System.out.println("searchValue : " + map.get("searchValue"));
		resultMap.put("startPage", StartPage);
		resultMap.put("endPage", endpage);
		resultMap.put("page", pageVO);
		resultMap.put("searchType", map.get("searchType"));
		resultMap.put("searchValue", map.get("searchValue"));
		return resultMap;
	}
}
