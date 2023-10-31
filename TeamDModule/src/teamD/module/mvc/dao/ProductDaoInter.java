package teamD.module.mvc.dao;

import java.util.List;

import teamD.module.mvc.dto.LCategoryVO;
import teamD.module.mvc.dto.ProductVO;
import teamD.module.mvc.dto.SCategoryVO;

public interface ProductDaoInter {
	public void prInsert(ProductVO vo);
	public List<LCategoryVO> lcList (); 
	public List<SCategoryVO> scList();
}
