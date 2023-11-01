package teamD.module.mvc.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import teamD.module.mvc.dto.LCategoryVO;
import teamD.module.mvc.dto.ProductVO;
import teamD.module.mvc.dto.SCategoryVO;

@Repository
public class ProductDao implements ProductDaoInter{
	
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public void prInsert(ProductVO vo) {
		ss.insert("product.add",vo);
	}

	@Override
	public List<LCategoryVO> lcList() {
		return ss.selectList("product.lclist");
	}

	@Override
	public List<SCategoryVO> scList(int lcnum) {
		return ss.selectList("product.sclist",lcnum);
	}

	@Override
	public List<ProductVO> prList(Map<String, String> map) {
		return ss.selectList("product.prlist");
	}

	@Override
	public int getTotal(Map<String, String> map) {
		System.out.println("토탈카운트 실행 " );
		
		for (Map.Entry<String, String> entry : map.entrySet()) {
		    String key2 = entry.getKey();
		    String value = entry.getValue();
		    System.out.println("토탈카운트 맵 Key: " + key2 + ", Value: " + value);
		}
		
		
		String key = null;
		int total = 0;
		Map<String, String> fakemap = new HashMap<String, String>();

		if (map.containsKey("lcnum")) {
		    key = "lcnum";
		} else if (map.containsKey("scnum")) {
		    key = "scnum";
		} 
		
		System.out.println("key : " + key);
		if("0".equals(map.get(key))) {

			total = ss.selectOne("product.totalCount", fakemap);
		}else {
			total = ss.selectOne("product.totalCount",map);
		}
		
		return total;
	}

	@Override
	public List<ProductVO> productList(Map<String, String> map) {
		return ss.selectList("product.prlist",map);
	}

	@Override
	public List<ProductVO> SearchByCategoryList(Map<String, String> map) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		Map<String, String> fakemap = new HashMap<String, String>();
		
		fakemap.put("begin", "1");
		fakemap.put("end", "10");
		
		
		String key = null;
		if (map.containsKey("lcnum")) {
		    key = "lcnum";
		} else if (map.containsKey("scnum")) {
		    key = "scnum";
		}
		
		
		for (Map.Entry<String, String> entry : map.entrySet()) {
		    String key2 = entry.getKey();
		    String value = entry.getValue();
		    System.out.println("Key: " + key2 + ", Value: " + value);
		}

		
		if (key != null) {
		    int value = Integer.parseInt(map.get(key));
		    if(key == "lcnum" || (key == "scnum" && !"0".equals(map.get(key)))) {
			    Map<String, String> targetMap = value == 0 ? fakemap : map;
			    list = ss.selectList("product.SearchByCategory", targetMap);
		    }else {
		    	list = ss.selectList("product.SearchByCategory", map);
		    }
		}
		return list;
	}

}
