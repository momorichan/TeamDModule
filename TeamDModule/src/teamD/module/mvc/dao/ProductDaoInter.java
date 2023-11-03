package teamD.module.mvc.dao;

import java.util.List;
import java.util.Map;

import teamD.module.mvc.dto.LCategoryVO;
import teamD.module.mvc.dto.ProductVO;
import teamD.module.mvc.dto.SCategoryVO;

public interface ProductDaoInter {
	public void prInsert(ProductVO vo); // 상품 등록
	public List<LCategoryVO> lcList (); // 대분류 카테고리 리스트
	public List<SCategoryVO> scList(int lcnum); //소분류 카테고리 리스트
	public int getTotal(Map<String, String> map); // 상품 개수
	public List<ProductVO> productList(Map<String, String> map); // 상품목록
	public LCategoryVO prDetail(int pnum); // 상품 상세보기
}
