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
public class ProductDao implements ProductDaoInter {

   @Autowired
   private SqlSessionTemplate ss;
   // 상품등록
   @Override
   public void prInsert(ProductVO vo) {
      ss.insert("product.add", vo);
   }   
   // 대분류 카테고리
   @Override
   public List<LCategoryVO> lcList() {
      return ss.selectList("product.lclist");
   }
   // 소분류 카테고리
   @Override
   public List<SCategoryVO> scList(int lcnum) {
      return ss.selectList("product.sclist", lcnum);
   }
   // 상품 개수
   @Override
   public int getTotal(Map<String, String> map) {
      return ss.selectOne("product.totalCount", map);
   }

   // 상품 목록
   @Override
   public List<ProductVO> productList(Map<String, String> map) {
      return  ss.selectList("product.prList", map);
   }

   // 상품 상세보기
   @Override
   public LCategoryVO prDetail(int pnum) {
      return ss.selectOne("product.prDetail", pnum);

   }

}