package teamD.module.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import teamD.module.mvc.dto.CartItemVO;

@Repository
public class CartDao implements CartDaoInter{

	@Autowired
	private SqlSessionTemplate ss;
	
	@Override
	public void cartInsert(CartItemVO vo) {
		ss.insert("cart.cartAdd", vo);
	}

	@Override
	public void log_cartAdd(Map<String, String> map) {
		ss.insert("cart.log_cartAdd", map);
	}

	@Override
	public int checkCart(Map<String, String> map) {
		
		return ss.selectOne("cart.checkCart", map);
	}

	@Override
	public void cartUpdate(CartItemVO vo) {
		ss.update("cart.cartUpdate", vo);
		
	}

	@Override
	public List<CartItemVO> cartList(String id) {
		return ss.selectList("cart.cartList", id);
	}

	@Override
	public void cartDelete(Map<String, String> map) {
		ss.delete("cart.cartDelete", map);
		
	}

	@Override
	public void log_cartDelete(Map<String, String> map) {
		ss.insert("cart.log_cartDelete", map);
		
	}
	
	

}
