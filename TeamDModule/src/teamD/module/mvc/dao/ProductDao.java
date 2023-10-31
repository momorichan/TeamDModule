package teamD.module.mvc.dao;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import teamD.module.mvc.dto.ProductVO;

@Repository
public class ProductDao implements ProductDaoInter{
	
	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public void prInsert(ProductVO vo) {
		ss.insert("product.add",vo);
	}

}
