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
		map.put("begin", "1");
		map.put("end", "10");
		list = dao.SearchByCategoryList(map);
		return list;
	}
	
	@GetMapping("/pagination")
	public Map<String, Object> getPaginationData(@RequestParam Map<String, String> paramMap) {
		//paramMap에 들어간 데이터 : 
		for (Map.Entry<String, String> entry : paramMap.entrySet()) {
		    String mykey = entry.getKey();
		    String myvalue = entry.getValue();
		    System.out.println("paramMap의 값             Key: " + mykey + ", Value: " + myvalue);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String cPage = paramMap.get("cPage");
		
        pageVO.setTotalRecord(dao.getTotal(paramMap));
        int totalRecord = pageVO.getTotalRecord();
        
        System.out.println("totalRecord : " + totalRecord);
        
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
        List<ProductVO> list = dao.SearchByCategoryList(map);
        System.out.println("Size : " + list.size());
        int StartPage = (int)((pageVO.getNowPage() - 1) / pageVO.getPagePerBlock()) * pageVO.getPagePerBlock() +1;
        int endpage = StartPage + pageVO.getPagePerBlock() - 1 ;
        if(endpage > pageVO.getTotalPage()) {
           endpage = pageVO.getTotalPage();
        }
        System.out.println("startPage : " + StartPage);
        System.out.println("endPage : " + endpage);
        System.out.println("page : " + pageVO);
        System.out.println("searchType : " + map.get("searchType"));
        System.out.println("searchValue : " + map.get("searchValue"));
        
        
        resultMap.put("startPage",StartPage);
        resultMap.put("endPage",endpage);
        resultMap.put("page",pageVO);
        resultMap.put("searchType",map.get("searchType"));
        resultMap.put("searchValue",map.get("searchValue"));
        
        return resultMap;
	}
	
	
	
	
	
	
	
	
	
}
