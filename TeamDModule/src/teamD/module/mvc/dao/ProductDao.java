package teamD.module.mvc.dao;

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
	public int getTotal(Map<String, String> paramMap) {
		return ss.selectOne("product.totalCount",paramMap);
	}

	@Override
	public List<ProductVO> productList(Map<String, String> map) {
		return ss.selectList("product.prlist",map);
	}

	@Override
	public List<ProductVO> SearchByCategoryList(int lcnum) {
		List<ProductVO> list;
		if(lcnum == 0) {
			int all = 0;
			list = ss.selectList("product.SearchByCategory", all);
		}else {
			list = ss.selectList("product.SearchByCategory", lcnum);
		}
		return list;
	}
}
