package teamD.module.mvc.dao;

import java.util.List;
import java.util.Map;

import teamD.module.mvc.dto.LCategoryVO;
import teamD.module.mvc.dto.ProductVO;
import teamD.module.mvc.dto.SCategoryVO;

public interface ProductDaoInter {
	public void prInsert(ProductVO vo);
	public List<LCategoryVO> lcList (); 
	public List<SCategoryVO> scList(int lcnum);
	public List<ProductVO> prList();
	public int getTotal(Map<String, String> paramMap);
	public List<ProductVO> productList(Map<String, String> map);
	public List<ProductVO> SearchByCategoryList(int lcnum);
}
